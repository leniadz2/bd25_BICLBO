﻿CREATE TABLE [ods].[W3_09_TELEF_TXT] (
  [CODIGOPERSONA] [varchar](10) NULL,
  [TELEFONOS09] [varchar](10) NULL,
  [FECHACREACIONS09] [varchar](8) NULL,
  [orden] [int] NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_W3_09_TELEF_TXT]
  ON [ods].[W3_09_TELEF_TXT] ([CODIGOPERSONA], [TELEFONOS09])
  ON [PRIMARY]
GO