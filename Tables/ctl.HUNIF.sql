﻿CREATE TABLE [ctl].[HUNIF] (
  [IDPROCESO] [varchar](15) NOT NULL,
  [PERSONAORIGEN] [varchar](10) NOT NULL,
  [CUENTAORIGEN] [varchar](3) NOT NULL,
  [PERSONADESTINO] [varchar](10) NOT NULL,
  [CUENTADESTINO] [varchar](3) NOT NULL,
  [TIPODEOPERACION] [varchar](1) NOT NULL,
  [USUARIODEREGISTRO] [varchar](10) NULL,
  [FECHADEREGISTRO_UNI] [varchar](19) NULL,
  [FECHACARGAINICIAL_UNI] [varchar](8) NULL,
  [FECHACARGAULTMODIF_UNI] [varchar](8) NULL,
  [date] [varchar](8) NULL,
  [hora] [varchar](8) NULL
)
ON [PRIMARY]
GO