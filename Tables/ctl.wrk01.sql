CREATE TABLE [ctl].[wrk01] (
  [date] [varchar](8) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [idx_wrk01_lookup]
  ON [ctl].[wrk01] ([date])
  ON [PRIMARY]
GO