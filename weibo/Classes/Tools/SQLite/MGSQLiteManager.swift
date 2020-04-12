//
//  MGSQLiteManager.swift
//  数据库_test
//
//  Created by 郝心如 on 2020/4/8.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import Foundation
import FMDB
///SQLite管理器
class MGSQLiteManager {
    
    ///单例
    static let shared = MGSQLiteManager()
    ///
    let queue:FMDatabaseQueue
    //构造函数
    private init() {
        
        //数据库的全路径
        let dbName = "status.db"
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        path = (path as NSString).appendingPathComponent(dbName)
        print("数据库的路径 :\(path)")
        
        //创建数据库队列
        queue = FMDatabaseQueue(path: path)!
        
        //打开数据库
        createTable()
        
        //注册通知
        //当回到桌面时执行
        NotificationCenter.default.addObserver(self, selector: #selector(clearDBCache), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    deinit {
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    @objc private func clearDBCache(){
        print("清理数据缓存")
    }
}

//MARK:微博数据操作
extension MGSQLiteManager {
    
    /// 从数据库加载微博字典数组
    /// - Parameters:
    ///   - userId: 当前登陆的用户账号
    ///   - since_id: 返回ID比since_id大的微博
    ///   - max_id: 返回ID比since_id  小的微博
    ///   - returns:返回反序列化的微博数据 生成字典
    func loadStatus(userId:String,since_id:Int64 = 0,max_id:Int64 = 0) -> [[String:AnyObject]] {
        
        var sql = "SELECT statusId,userId,status FROM T_Status \n"
        sql += "WHERE userId = \(userId) \n"
        //上拉下拉
        if since_id > 0 {
            sql += "AND statusId > \(since_id) \n"
        }else if max_id > 0{
            sql += "AND statusId < \(max_id) \n"
        }
        
        sql += "ORDER BY statusId DESC LIMIT 20"
        
        //print(sql)
        
        //执行sql
        let array = execRecordSet(sql: sql)
        
        //3.遍历数组 反序列化
        var result = [[String:AnyObject]]()
        
        for dict in array {
            guard let jsonData = dict["status"] as? Data ,
                let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:AnyObject]
            else {
                continue
            }
            result.append(json)
            
        }
        
        return result
    }
    
    
    
    
    /// 新增或者修改微博数据，微博数据在刷新的时候可能会出现重叠
    /// - Parameters:
    ///   - userId: 当前登陆用户的id
    ///   - array: 从网络获取的 字典数组
    func updateStatus(userId:String,array:[[String:AnyObject]]) {
        
        //1. 准备sql
        /*
         statusId：微博号
         userId ：用户ID
         status : 微博字典的json二进制数据
         */
        let sql = "INSERT OR REPLACE INTO T_Status (statusId,userId,status) VALUES (?,?,?);"

        //2. 执行sql
        queue.inTransaction { (db, rollback) in
            //  遍历数组 逐条插入微博数据
            for dict in array {

                //将字典序列化成二进制数据
                guard
                    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []),
                    let statusId = dict["idstr"] as? String
                    else {
                      continue
                }
                // 执行sql
                if db.executeUpdate(sql, withArgumentsIn: [statusId,userId,jsonData]) == false {
                    
                    // FIXME: 需要回滚
                    rollback.pointee = true
                    break
                }
                
            }
        }
    }
    
}

//MARK: - 创建数据表以及其他私有方法
extension MGSQLiteManager {
    
    func execRecordSet(sql:String) -> [[String:AnyObject]] {
        
        var result = [[String:AnyObject]]()
        
        //执行sql 查询数据不会修改数据 所以不会开启事务
        //事务的目的 是为了保证数据的安全
        queue.inDatabase { (db) in
            
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            
            //逐行 遍历结果集合
            while rs.next() {
                
                //1.列数
                let colCount = rs.columnCount
                
                //2. 遍历所有列
                for col in 0..<colCount {
                    
                    //3> 列名 ->KEY
                    guard
                        let name = rs.columnName(for: col),
                        //4>  值
                        let value = rs.object(forColumnIndex: col) as AnyObject?
                        else {
                            continue
                    }
                    
                    result.append([name:value])
                }
            }
            
        }
        return result
    }
    
    ///创建数据表
    func createTable() {
        
        //1.准备SQL
        guard
            let path = Bundle.main.path(forResource: "status.sql", ofType: nil),
            let sql = try? String(contentsOfFile: path)
        else {
                return
        }
        //print(sql)
        //2. 执行SQL
        queue.inDatabase { (db) in
            
            if db.executeStatements(sql) == true {
                print("创表成功")
            } else{
                print("创表失败")
            }
        }
        print("over")
    }
    
}
