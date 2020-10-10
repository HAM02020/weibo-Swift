
CREATE TABLE IF NOT EXISTS "Status" (
  "statusId" INTEGER NOT NULL,
  "userId" INTEGER NOT NULL,
  "status" TEXT,
  "creatTime" TEXT DEFAULT (datetime('now','localtime')),
  PRIMARY KEY ("statusId", "userId")
);
