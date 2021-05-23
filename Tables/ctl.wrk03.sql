CREATE TABLE [ctl].[wrk03] (
  [filename] [varchar](500) NULL,
  [md5] [varchar](100) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [idx_wrk03_lookup]
  ON [ctl].[wrk03] ([filename], [md5])
  ON [PRIMARY]
GO