﻿CREATE TABLE [bds].[x_TABLONx] (
  [CODIGOPERSONA] [varchar](10) NOT NULL,
  [NUMTARJETABONUS] [varchar](19) NOT NULL,
  [TIPOTARJETA] [varchar](20) NULL,
  [CODIGOTIPOPERSONA] [varchar](2) NULL,
  [CODIGOTIPOPERSONA_D] [varchar](8) NULL,
  [TIPODEDOCUMENTO] [varchar](4) NULL,
  [TIPODEDOCUMENTO_D] [varchar](11) NULL,
  [NRODOCUMENTO] [varchar](15) NULL,
  [NRORUC] [varchar](11) NULL,
  [NOMBRES] [varchar](100) NULL,
  [APELLIDOPATERNO] [varchar](50) NULL,
  [APELLIDOMATERNO] [varchar](50) NULL,
  [FECHANACIMIENTO] [varchar](8) NULL,
  [EDAD] [int] NULL,
  [EDAD_RANGO] [varchar](13) NULL,
  [SEXO_TIT] [varchar](1) NULL,
  [SEXO_TIT_D] [varchar](11) NULL,
  [FLAGESTADOCIVIL] [varchar](1) NULL,
  [FLAGESTADOCIVIL_D] [varchar](11) NULL,
  [FLAGTIENEHIJOS] [varchar](1) NULL,
  [FLAGTIENEHIJOS_D] [varchar](2) NULL,
  [FLAGTIENETELEFONO] [varchar](1) NULL,
  [FLAGTIENETELEFONO_D] [varchar](2) NULL,
  [FLAGTIENECORREO] [varchar](1) NULL,
  [FLAGTIENECORREO_D] [varchar](2) NULL,
  [FLAGCOMPARTEDATOS] [varchar](1) NULL,
  [FLAGCOMPARTEDATOS_D] [varchar](2) NULL,
  [FLAGAUTCANJE] [varchar](1) NULL,
  [FLAGAUTCANJE_D] [varchar](2) NULL,
  [FLAGCLTEFALLECIDO] [varchar](1) NULL,
  [FLAGCLTEFALLECIDO_D] [varchar](2) NULL,
  [RAZONSOCIAL] [varchar](50) NULL,
  [FECHACREACION_PER] [varchar](8) NULL,
  [HORACREACION_PER] [varchar](8) NULL,
  [FECHAULTMODIF_PER] [varchar](8) NULL,
  [FECHACARGAINICIAL_PER] [varchar](8) NULL,
  [FECHACARGAULTMODIF_PER] [varchar](8) NULL,
  [CODPOS] [varchar](6) NULL,
  [DIRECCION] [varchar](150) NULL,
  [DEPARTAMENTO] [varchar](25) NULL,
  [PROVINCIA] [varchar](25) NULL,
  [DISTRITO] [varchar](25) NULL,
  [FLAGULTIMO_DIR] [varchar](1) NULL,
  [REFERENCIA] [varchar](150) NULL,
  [ESTADO] [varchar](1) NULL,
  [ESTADO_D] [varchar](6) NULL,
  [COORDENADAX] [varchar](20) NULL,
  [COORDENADAY] [varchar](20) NULL,
  [FLAGCOORDENADA] [varchar](1) NULL,
  [NSE] [varchar](1) NULL,
  [TELEFONO] [varchar](10) NULL,
  [TELEFONO_D] [varchar](10) NULL,
  [FECHACREACION_TEL] [varchar](8) NULL,
  [EMAIL] [varchar](100) NULL,
  [FECHACREACION_EML] [varchar](8) NULL,
  [HIJ_AS] [int] NULL,
  [HIJ_OS] [int] NULL,
  [HIJ_NN] [int] NULL,
  [HIJ_TOT] [int] NULL,
  [CODIGODEPARTICIPANTE] [varchar](4) NULL,
  [CODIGODELOCAL] [varchar](4) NULL,
  [FECHATRANSACCION_CAB] [varchar](8) NULL,
  [HORATRANSACCION_CAB] [varchar](8) NULL,
  [HORATRANSSECCION_CAB] [varchar](6) NULL,
  [NROPOS] [varchar](6) NULL,
  [NROTRNPOS] [varchar](6) NULL,
  [MONTOTOTAL] [varchar](15) NULL,
  [SIGNO_MT] [varchar](1) NULL,
  [MONTOTOTALNUM] [float] NULL,
  [PTOSACUMULADOS] [varchar](15) NULL,
  [SIGNO_PA] [varchar](1) NULL,
  [PTOSACUMULADOSNUM] [float] NULL,
  [FECHAASIGNACION_CAB] [varchar](8) NULL,
  [CODIGODEPROMOCION] [varchar](7) NULL,
  [DESCRIPCION_PRM] [varchar](50) NULL,
  [TIPODETRANSACCION] [varchar](10) NULL,
  [NOMBREDEALER] [varchar](50) NULL,
  [IDTRX] [varchar](18) NULL,
  [SEC] [varchar](3) NULL,
  [PLU] [varchar](14) NULL,
  [CANTIDAD] [varchar](9) NULL,
  [CANTIDADNUM] [float] NULL,
  [MONTOPARCIAL] [varchar](15) NULL,
  [SIGNO_MP] [varchar](1) NULL,
  [MONTOPARCIALNUM] [float] NULL,
  [RE_UNDECO] [varchar](60) NULL,
  [SAP_CONTRATO] [varchar](60) NULL,
  [DESCRIPCIONTDA] [varchar](60) NULL,
  [USUARIO] [varchar](8) NULL,
  [CATEGORIA] [varchar](60) NULL,
  [SUBCATEGORIA] [varchar](60) NULL
)
ON [PRIMARY]
GO