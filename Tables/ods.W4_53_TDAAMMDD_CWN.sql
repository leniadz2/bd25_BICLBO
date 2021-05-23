CREATE TABLE [ods].[W4_53_TDAAMMDD_CWN] (
  [IDTRX] [varchar](18) NULL,
  [SEC] [varchar](3) NULL,
  [PLU] [varchar](14) NULL,
  [CANTIDAD] [varchar](9) NULL,
  [MONTOPARCIAL] [varchar](15) NULL,
  [SIGNO_MP] [varchar](1) NULL,
  [ARCHIVOORIGEN] [varchar](58) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX1_W4_53_TDAAMMDD_CWN]
  ON [ods].[W4_53_TDAAMMDD_CWN] ([IDTRX])
  ON [PRIMARY]
GO