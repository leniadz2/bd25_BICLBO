CREATE TABLE [ctl].[HEMAIL] (
  [CODIGOPERSONA] [varchar](10) NOT NULL,
  [EMAIL] [varchar](100) NOT NULL,
  [FLAGULTIMO_EML] [varchar](1) NULL,
  [FECHACREACION_EML] [varchar](8) NULL,
  [FECHACARGAINICIAL_EML] [varchar](8) NULL,
  [FECHACARGAULTMODIF_EML] [varchar](8) NULL,
  [orden] [int] NULL,
  [date] [varchar](8) NULL,
  [hora] [varchar](8) NULL
)
ON [PRIMARY]
GO