CREATE TABLE [ods].[W1_PERSONA] (
  [CODIGOPERSONA] [varchar](10) NULL,
  [CODIGOTIPOPERSONA] [varchar](2) NULL,
  [TIPODEDOCUMENTO] [varchar](4) NULL,
  [NRODOCUMENTO] [varchar](15) NULL,
  [NRORUC] [varchar](11) NULL,
  [NOMBRES] [varchar](100) NULL,
  [APELLIDOPATERNO] [varchar](50) NULL,
  [APELLIDOMATERNO] [varchar](50) NULL,
  [FECHANACIMIENTO] [varchar](8) NULL,
  [SEXO_TIT] [varchar](1) NULL,
  [FLAGESTADOCIVIL] [varchar](1) NULL,
  [FLAGTIENEHIJOS] [varchar](1) NULL,
  [FLAGTIENETELEFONO] [varchar](1) NULL,
  [FLAGTIENECORREO] [varchar](1) NULL,
  [FLAGCOMPARTEDATOS] [varchar](1) NULL,
  [FLAGAUTCANJE] [varchar](1) NULL,
  [FLAGCLTEFALLECIDO] [varchar](1) NULL,
  [RAZONSOCIAL] [varchar](50) NULL,
  [FECHACREACION_PER] [varchar](8) NULL,
  [HORACREACION_PER] [varchar](8) NULL,
  [FECHAULTMODIF_PER] [varchar](8) NULL
)
ON [PRIMARY]
GO