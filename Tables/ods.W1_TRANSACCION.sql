CREATE TABLE [ods].[W1_TRANSACCION] (
  [CODIGODEPARTICIPANTE] [varchar](4) NULL,
  [CODIGODELOCAL] [varchar](4) NULL,
  [NUMTARJETABONUS] [varchar](19) NULL,
  [FECHATRANSACCION_CAB] [varchar](8) NULL,
  [HORATRANSACCION_CAB] [varchar](8) NULL,
  [NROPOS] [varchar](6) NULL,
  [NROTRNPOS] [varchar](6) NULL,
  [MONTOTOTAL] [varchar](15) NULL,
  [SIGNO_MT] [varchar](1) NULL,
  [PTOSACUMULADOS] [varchar](15) NULL,
  [SIGNO_PA] [varchar](1) NULL,
  [FECHAASIGNACION_CAB] [varchar](8) NULL,
  [CODIGODEPROMOCION] [varchar](7) NULL,
  [DESCRIPCION_PRM] [varchar](50) NULL,
  [TIPODETRANSACCION] [varchar](10) NULL,
  [NOMBREDEALER] [varchar](50) NULL,
  [IDTRX] [varchar](18) NULL,
  [SEC] [varchar](3) NULL,
  [PLU] [varchar](14) NULL,
  [CANTIDAD] [varchar](9) NULL,
  [MONTOPARCIAL] [varchar](15) NULL,
  [SIGNO_MP] [varchar](1) NULL
)
ON [PRIMARY]
GO