CREATE TABLE [ctl].[wrk02] (
  [hora] [varchar](8) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [idx_wrk02_lookup]
  ON [ctl].[wrk02] ([hora])
  ON [PRIMARY]
GO