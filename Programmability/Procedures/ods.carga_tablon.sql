SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [ods].[carga_tablon]
AS
BEGIN

DECLARE @date NVARCHAR(8),
		@hora NVARCHAR(8);

SET @date = (select date from ctl.wrk01);
SET @hora = (select hora from ctl.wrk02);

--TABLON_PRE

TRUNCATE TABLE bds.TABLON_PRE   ;

ALTER TABLE bds.TABLON_PRE
DROP CONSTRAINT PK_TABLON_PRE;

INSERT INTO bds.TABLON_PRE
SELECT IIF(C.CODIGOPERSONA       IS NULL, '0000000000'           ,C.CODIGOPERSONA      ) AS CODIGOPERSONA     ,
       T.NUMTARJETABONUS         ,
       IIF(C.TIPOTARJETA         IS NULL, 'SIN DESCRIPCION'      ,C.TIPOTARJETA        ) AS TIPOTARJETA        ,
       IIF(C.CODIGOTIPOPERSONA   IS NULL, 'XX'                   ,C.CODIGOTIPOPERSONA  ) AS CODIGOTIPOPERSONA  ,
       IIF(C.CODIGOTIPOPERSONA_D IS NULL, 'XXXXXXXX'             ,C.CODIGOTIPOPERSONA_D) AS CODIGOTIPOPERSONA_D,
       IIF(C.TIPODEDOCUMENTO     IS NULL, 'XXXX'                 ,C.TIPODEDOCUMENTO    ) AS TIPODEDOCUMENTO    ,
       IIF(C.TIPODEDOCUMENTO_D   IS NULL, 'XXXX'                 ,C.TIPODEDOCUMENTO_D  ) AS TIPODEDOCUMENTO_D  ,
       IIF(C.NRODOCUMENTO        IS NULL, 'XXXXXXXX'             ,C.NRODOCUMENTO       ) AS NRODOCUMENTO       ,
       IIF(C.NRORUC              IS NULL, 'XXXXXXXXXXX'          ,C.NRORUC             ) AS NRORUC             ,
       IIF(C.NOMBRES             IS NULL, 'SIN DESCRIPCION'      ,C.NOMBRES            ) AS NOMBRES            ,
       IIF(C.APELLIDOPATERNO     IS NULL, 'SIN DESCRIPCION'      ,C.APELLIDOPATERNO    ) AS APELLIDOPATERNO    ,
       IIF(C.APELLIDOMATERNO     IS NULL, 'SIN DESCRIPCION'      ,C.APELLIDOMATERNO    ) AS APELLIDOMATERNO    ,
       IIF(C.FECHANACIMIENTO     IS NULL, '19000101'             ,C.FECHANACIMIENTO    ) AS FECHANACIMIENTO    ,
       IIF(C.EDAD                IS NULL, 0                      ,C.EDAD               ) AS EDAD               ,
       IIF(C.EDAD_RANGO          IS NULL, 'XX-XX'                ,C.EDAD_RANGO         ) AS EDAD_RANGO         ,
       IIF(C.SEXO_TIT            IS NULL, 'X'                    ,C.SEXO_TIT           ) AS SEXO_TIT           ,
       IIF(C.SEXO_TIT_D          IS NULL, 'XXXXXXXXXXX'          ,C.SEXO_TIT_D         ) AS SEXO_TIT_D         ,
       IIF(C.FLAGESTADOCIVIL     IS NULL, 'X'                    ,C.FLAGESTADOCIVIL    ) AS FLAGESTADOCIVIL    ,
       IIF(C.FLAGESTADOCIVIL_D   IS NULL, 'XXXXXXXXXXX'          ,C.FLAGESTADOCIVIL_D  ) AS FLAGESTADOCIVIL_D  ,
       IIF(C.FLAGTIENEHIJOS      IS NULL, 'X'                    ,C.FLAGTIENEHIJOS     ) AS FLAGTIENEHIJOS     ,
       IIF(C.FLAGTIENEHIJOS_D    IS NULL, 'XX'                   ,C.FLAGTIENEHIJOS_D   ) AS FLAGTIENEHIJOS_D   ,
       IIF(C.FLAGTIENETELEFONO   IS NULL, 'X'                    ,C.FLAGTIENETELEFONO  ) AS FLAGTIENETELEFONO  ,
       IIF(C.FLAGTIENETELEFONO_D IS NULL, 'XX'                   ,C.FLAGTIENETELEFONO_D) AS FLAGTIENETELEFONO_D,
       IIF(C.FLAGTIENECORREO     IS NULL, 'X'                    ,C.FLAGTIENECORREO    ) AS FLAGTIENECORREO    ,
       IIF(C.FLAGTIENECORREO_D   IS NULL, 'XX'                   ,C.FLAGTIENECORREO_D  ) AS FLAGTIENECORREO_D  ,
       IIF(C.FLAGCOMPARTEDATOS   IS NULL, 'X'                    ,C.FLAGCOMPARTEDATOS  ) AS FLAGCOMPARTEDATOS  ,
       IIF(C.FLAGCOMPARTEDATOS_D IS NULL, 'XX'                   ,C.FLAGCOMPARTEDATOS_D) AS FLAGCOMPARTEDATOS_D,
       IIF(C.FLAGAUTCANJE        IS NULL, 'X'                    ,C.FLAGAUTCANJE       ) AS FLAGAUTCANJE       ,
       IIF(C.FLAGAUTCANJE_D      IS NULL, 'XX'                   ,C.FLAGAUTCANJE_D     ) AS FLAGAUTCANJE_D     ,
       IIF(C.FLAGCLTEFALLECIDO   IS NULL, 'X'                    ,C.FLAGCLTEFALLECIDO  ) AS FLAGCLTEFALLECIDO  ,
       IIF(C.FLAGCLTEFALLECIDO_D IS NULL, 'XX'                   ,C.FLAGCLTEFALLECIDO_D) AS FLAGCLTEFALLECIDO_D,
       C.RAZONSOCIAL             ,
       C.FECHACREACION_PER       ,
       C.HORACREACION_PER        ,
       C.FECHAULTMODIF_PER       ,
       C.FECHACARGAINICIAL_PER   ,
       C.FECHACARGAULTMODIF_PER  ,
       IIF(C.CODPOS              IS NULL, 'XXX'                   ,C.CODPOS)       AS CODPOS           ,
       IIF(C.DIRECCION           IS NULL, 'SIN DESCRIPCION'       ,C.DIRECCION)    AS DIRECCION        ,
       IIF(C.DEPARTAMENTO        IS NULL, 'XXXX'                  ,C.DEPARTAMENTO) AS DEPARTAMENTO     ,
       IIF(C.PROVINCIA           IS NULL, 'XXXX'                  ,C.PROVINCIA)    AS PROVINCIA        ,
       IIF(C.DISTRITO            IS NULL, 'XXXX'                  ,C.DISTRITO)     AS DISTRITO         ,
       C.FLAGULTIMO_DIR          ,
       C.REFERENCIA              ,
       C.ESTADO                  ,
       C.ESTADO_D                ,
       C.COORDENADAX             ,
       C.COORDENADAY             ,
       IIF(C.FLAGCOORDENADA      IS NULL, '0'                     ,C.FLAGCOORDENADA) AS FLAGCOORDENADA ,
       C.NSE                     ,
       C.TELEFONO                ,
       C.TELEFONO_D              ,
       C.FECHACREACION_TEL       ,
       C.EMAIL                   ,
       C.FECHACREACION_EML       ,
       C.HIJ_AS                  ,
       C.HIJ_OS                  ,
       C.HIJ_NN                  ,
       C.HIJ_TOT                 ,
       T.CODIGODEPARTICIPANTE    ,
       T.CODIGODELOCAL           ,
       T.FECHATRANSACCION_CAB    ,
       T.HORATRANSACCION_CAB     ,
       T.HORATRANSSECCION_CAB    ,
       T.NROPOS                  ,
       T.NROTRNPOS               ,
       T.MONTOTOTAL              ,
       T.SIGNO_MT                ,
       T.MONTOTOTALNUM           ,
       T.PTOSACUMULADOS          ,
       T.SIGNO_PA                ,
       T.PTOSACUMULADOSNUM       ,
       T.FECHAASIGNACION_CAB     ,
       T.CODIGODEPROMOCION       ,
       T.DESCRIPCION_PRM         ,
       T.TIPODETRANSACCION       ,
       T.NOMBREDEALER            ,
       T.IDTRX                   ,
       T.SEC                     ,
       T.PLU                     ,
       T.CANTIDAD                ,
       T.CANTIDADNUM             ,
       T.MONTOPARCIAL            ,
       T.SIGNO_MP                ,
       T.MONTOPARCIALNUM         ,
       A.RE_UNDECO               ,
       L.SAP_CONTRATO            ,
       L.DESCRIPCIONTDA          ,
       L.USUARIO                 ,
       L.CATEGORIA               ,
       L.SUBCATEGORIA
FROM bds.TRANSACCION AS T
         LEFT JOIN bds.CLIENTES AS C  ON T.NUMTARJETABONUS = C.NUMTARJETABONUS
         LEFT JOIN bds.ASOCIADO AS A  ON T.CODIGODEPARTICIPANTE = A.ASOCIADO
         LEFT JOIN bds.LOCATARIO AS L ON T.CODIGODEPARTICIPANTE = L.ASOCIADO AND T.CODIGODELOCAL = L.LOCATARIO
WHERE C.ORDTARJETABONUS = 1;

ALTER TABLE bds.TABLON_PRE ADD  CONSTRAINT PK_TABLON_PRE PRIMARY KEY CLUSTERED 
(
	CODIGOPERSONA       ,
	NUMTARJETABONUS     ,
	CODIGODEPARTICIPANTE,
	CODIGODELOCAL       ,
	FECHATRANSACCION_CAB,
	NROPOS              ,
	NROTRNPOS           ,
	IDTRX               ,
	SEC
);

--TABLON_DIF

TRUNCATE TABLE bds.TABLON_DIF   ;

ALTER TABLE bds.TABLON_DIF
DROP CONSTRAINT PK_TABLON_DIF;

INSERT INTO bds.TABLON_DIF
SELECT CODIGOPERSONA           ,
       NUMTARJETABONUS         ,
       TIPOTARJETA             ,
       CODIGOTIPOPERSONA       ,
       CODIGOTIPOPERSONA_D     ,
       TIPODEDOCUMENTO         ,
       TIPODEDOCUMENTO_D       ,
       NRODOCUMENTO            ,
       NRORUC                  ,
       NOMBRES                 ,
       APELLIDOPATERNO         ,
       APELLIDOMATERNO         ,
       FECHANACIMIENTO         ,
       EDAD                    ,
       EDAD_RANGO              ,
       SEXO_TIT                ,
       SEXO_TIT_D              ,
       FLAGESTADOCIVIL         ,
       FLAGESTADOCIVIL_D       ,
       FLAGTIENEHIJOS          ,
       FLAGTIENEHIJOS_D        ,
       FLAGTIENETELEFONO       ,
       FLAGTIENETELEFONO_D     ,
       FLAGTIENECORREO         ,
       FLAGTIENECORREO_D       ,
       FLAGCOMPARTEDATOS       ,
       FLAGCOMPARTEDATOS_D     ,
       FLAGAUTCANJE            ,
       FLAGAUTCANJE_D          ,
       FLAGCLTEFALLECIDO       ,
       FLAGCLTEFALLECIDO_D     ,
       RAZONSOCIAL             ,
       FECHACREACION_PER       ,
       HORACREACION_PER        ,
       FECHAULTMODIF_PER       ,
       FECHACARGAINICIAL_PER   ,
       FECHACARGAULTMODIF_PER  ,
       CODPOS                  ,
       DIRECCION               ,
       DEPARTAMENTO            ,
       PROVINCIA               ,
       DISTRITO                ,
       FLAGULTIMO_DIR          ,
       REFERENCIA              ,
       ESTADO                  ,
       ESTADO_D                ,
       COORDENADAX             ,
       COORDENADAY             ,
       FLAGCOORDENADA          ,
       NSE                     ,
       TELEFONO                ,
       TELEFONO_D              ,
       FECHACREACION_TEL       ,
       EMAIL                   ,
       FECHACREACION_EML       ,
       HIJ_AS                  ,
       HIJ_OS                  ,
       HIJ_NN                  ,
       HIJ_TOT                 ,
       CODIGODEPARTICIPANTE    ,
       CODIGODELOCAL           ,
       FECHATRANSACCION_CAB    ,
       HORATRANSACCION_CAB     ,
       HORATRANSSECCION_CAB    ,
       NROPOS                  ,
       NROTRNPOS               ,
       MONTOTOTAL              ,
       SIGNO_MT                ,
       MONTOTOTALNUM           ,
       PTOSACUMULADOS          ,
       SIGNO_PA                ,
       PTOSACUMULADOSNUM       ,
       FECHAASIGNACION_CAB     ,
       CODIGODEPROMOCION       ,
       DESCRIPCION_PRM         ,
       TIPODETRANSACCION       ,
       NOMBREDEALER            ,
       IDTRX                   ,
       SEC                     ,
       PLU                     ,
       CANTIDAD                ,
       CANTIDADNUM             ,
       MONTOPARCIAL            ,
       SIGNO_MP                ,
       MONTOPARCIALNUM         ,
       RE_UNDECO               ,
       SAP_CONTRATO            ,
       DESCRIPCIONTDA          ,
       USUARIO                 ,
       CATEGORIA               ,
       SUBCATEGORIA
  FROM bds.TABLON_PRE 
EXCEPT
SELECT CODIGOPERSONA           ,
       NUMTARJETABONUS         ,
       TIPOTARJETA             ,
       CODIGOTIPOPERSONA       ,
       CODIGOTIPOPERSONA_D     ,
       TIPODEDOCUMENTO         ,
       TIPODEDOCUMENTO_D       ,
       NRODOCUMENTO            ,
       NRORUC                  ,
       NOMBRES                 ,
       APELLIDOPATERNO         ,
       APELLIDOMATERNO         ,
       FECHANACIMIENTO         ,
       EDAD                    ,
       EDAD_RANGO              ,
       SEXO_TIT                ,
       SEXO_TIT_D              ,
       FLAGESTADOCIVIL         ,
       FLAGESTADOCIVIL_D       ,
       FLAGTIENEHIJOS          ,
       FLAGTIENEHIJOS_D        ,
       FLAGTIENETELEFONO       ,
       FLAGTIENETELEFONO_D     ,
       FLAGTIENECORREO         ,
       FLAGTIENECORREO_D       ,
       FLAGCOMPARTEDATOS       ,
       FLAGCOMPARTEDATOS_D     ,
       FLAGAUTCANJE            ,
       FLAGAUTCANJE_D          ,
       FLAGCLTEFALLECIDO       ,
       FLAGCLTEFALLECIDO_D     ,
       RAZONSOCIAL             ,
       FECHACREACION_PER       ,
       HORACREACION_PER        ,
       FECHAULTMODIF_PER       ,
       FECHACARGAINICIAL_PER   ,
       FECHACARGAULTMODIF_PER  ,
       CODPOS                  ,
       DIRECCION               ,
       DEPARTAMENTO            ,
       PROVINCIA               ,
       DISTRITO                ,
       FLAGULTIMO_DIR          ,
       REFERENCIA              ,
       ESTADO                  ,
       ESTADO_D                ,
       COORDENADAX             ,
       COORDENADAY             ,
       FLAGCOORDENADA          ,
       NSE                     ,
       TELEFONO                ,
       TELEFONO_D              ,
       FECHACREACION_TEL       ,
       EMAIL                   ,
       FECHACREACION_EML       ,
       HIJ_AS                  ,
       HIJ_OS                  ,
       HIJ_NN                  ,
       HIJ_TOT                 ,
       CODIGODEPARTICIPANTE    ,
       CODIGODELOCAL           ,
       FECHATRANSACCION_CAB    ,
       HORATRANSACCION_CAB     ,
       HORATRANSSECCION_CAB    ,
       NROPOS                  ,
       NROTRNPOS               ,
       MONTOTOTAL              ,
       SIGNO_MT                ,
       MONTOTOTALNUM           ,
       PTOSACUMULADOS          ,
       SIGNO_PA                ,
       PTOSACUMULADOSNUM       ,
       FECHAASIGNACION_CAB     ,
       CODIGODEPROMOCION       ,
       DESCRIPCION_PRM         ,
       TIPODETRANSACCION       ,
       NOMBREDEALER            ,
       IDTRX                   ,
       SEC                     ,
       PLU                     ,
       CANTIDAD                ,
       CANTIDADNUM             ,
       MONTOPARCIAL            ,
       SIGNO_MP                ,
       MONTOPARCIALNUM         ,
       RE_UNDECO               ,
       SAP_CONTRATO            ,
       DESCRIPCIONTDA          ,
       USUARIO                 ,
       CATEGORIA               ,
       SUBCATEGORIA
  FROM bds.TABLON;

ALTER TABLE bds.TABLON_DIF ADD  CONSTRAINT PK_TABLON_DIF PRIMARY KEY CLUSTERED 
(
	CODIGOPERSONA       ,
	NUMTARJETABONUS     ,
	CODIGODEPARTICIPANTE,
	CODIGODELOCAL       ,
	FECHATRANSACCION_CAB,
	NROPOS              ,
	NROTRNPOS           ,
	IDTRX               ,
	SEC
);

--TABLON

--no se trunca tablon

MERGE INTO bds.TABLON AS t
USING bds.TABLON_DIF AS s
   ON t.CODIGOPERSONA        = s.CODIGOPERSONA
  AND t.NUMTARJETABONUS      = s.NUMTARJETABONUS
  AND t.CODIGODEPARTICIPANTE = s.CODIGODEPARTICIPANTE
  AND t.CODIGODELOCAL        = s.CODIGODELOCAL
  AND t.FECHATRANSACCION_CAB = s.FECHATRANSACCION_CAB
  AND t.NROPOS               = s.NROPOS
  AND t.NROTRNPOS            = s.NROTRNPOS
  AND t.IDTRX                = s.IDTRX
  AND t.SEC                  = s.SEC
 WHEN MATCHED THEN
      UPDATE SET t.CODIGOPERSONA           = s.CODIGOPERSONA           ,
                 t.NUMTARJETABONUS         = s.NUMTARJETABONUS         ,
                 t.TIPOTARJETA             = s.TIPOTARJETA             ,
                 t.CODIGOTIPOPERSONA       = s.CODIGOTIPOPERSONA       ,
                 t.CODIGOTIPOPERSONA_D     = s.CODIGOTIPOPERSONA_D     ,
                 t.TIPODEDOCUMENTO         = s.TIPODEDOCUMENTO         ,
                 t.TIPODEDOCUMENTO_D       = s.TIPODEDOCUMENTO_D       ,
                 t.NRODOCUMENTO            = s.NRODOCUMENTO            ,
                 t.NRORUC                  = s.NRORUC                  ,
                 t.NOMBRES                 = s.NOMBRES                 ,
                 t.APELLIDOPATERNO         = s.APELLIDOPATERNO         ,
                 t.APELLIDOMATERNO         = s.APELLIDOMATERNO         ,
                 t.FECHANACIMIENTO         = s.FECHANACIMIENTO         ,
                 t.EDAD                    = s.EDAD                    ,
                 t.EDAD_RANGO              = s.EDAD_RANGO              ,
                 t.SEXO_TIT                = s.SEXO_TIT                ,
                 t.SEXO_TIT_D              = s.SEXO_TIT_D              ,
                 t.FLAGESTADOCIVIL         = s.FLAGESTADOCIVIL         ,
                 t.FLAGESTADOCIVIL_D       = s.FLAGESTADOCIVIL_D       ,
                 t.FLAGTIENEHIJOS          = s.FLAGTIENEHIJOS          ,
                 t.FLAGTIENEHIJOS_D        = s.FLAGTIENEHIJOS_D        ,
                 t.FLAGTIENETELEFONO       = s.FLAGTIENETELEFONO       ,
                 t.FLAGTIENETELEFONO_D     = s.FLAGTIENETELEFONO_D     ,
                 t.FLAGTIENECORREO         = s.FLAGTIENECORREO         ,
                 t.FLAGTIENECORREO_D       = s.FLAGTIENECORREO_D       ,
                 t.FLAGCOMPARTEDATOS       = s.FLAGCOMPARTEDATOS       ,
                 t.FLAGCOMPARTEDATOS_D     = s.FLAGCOMPARTEDATOS_D     ,
                 t.FLAGAUTCANJE            = s.FLAGAUTCANJE            ,
                 t.FLAGAUTCANJE_D          = s.FLAGAUTCANJE_D          ,
                 t.FLAGCLTEFALLECIDO       = s.FLAGCLTEFALLECIDO       ,
                 t.FLAGCLTEFALLECIDO_D     = s.FLAGCLTEFALLECIDO_D     ,
                 t.RAZONSOCIAL             = s.RAZONSOCIAL             ,
                 t.FECHACREACION_PER       = s.FECHACREACION_PER       ,
                 t.HORACREACION_PER        = s.HORACREACION_PER        ,
                 t.FECHAULTMODIF_PER       = s.FECHAULTMODIF_PER       ,
                 t.FECHACARGAINICIAL_PER   = s.FECHACARGAINICIAL_PER   ,
                 t.FECHACARGAULTMODIF_PER  = s.FECHACARGAULTMODIF_PER  ,
                 t.CODPOS                  = s.CODPOS                  ,
                 t.DIRECCION               = s.DIRECCION               ,
                 t.DEPARTAMENTO            = s.DEPARTAMENTO            ,
                 t.PROVINCIA               = s.PROVINCIA               ,
                 t.DISTRITO                = s.DISTRITO                ,
                 t.FLAGULTIMO_DIR          = s.FLAGULTIMO_DIR          ,
                 t.REFERENCIA              = s.REFERENCIA              ,
                 t.ESTADO                  = s.ESTADO                  ,
                 t.ESTADO_D                = s.ESTADO_D                ,
                 t.COORDENADAX             = s.COORDENADAX             ,
                 t.COORDENADAY             = s.COORDENADAY             ,
                 t.FLAGCOORDENADA          = s.FLAGCOORDENADA          ,
                 t.NSE                     = s.NSE                     ,
                 t.TELEFONO                = s.TELEFONO                ,
                 t.TELEFONO_D              = s.TELEFONO_D              ,
                 t.FECHACREACION_TEL       = s.FECHACREACION_TEL       ,
                 t.EMAIL                   = s.EMAIL                   ,
                 t.FECHACREACION_EML       = s.FECHACREACION_EML       ,
                 t.HIJ_AS                  = s.HIJ_AS                  ,
                 t.HIJ_OS                  = s.HIJ_OS                  ,
                 t.HIJ_NN                  = s.HIJ_NN                  ,
                 t.HIJ_TOT                 = s.HIJ_TOT                 ,
                 t.CODIGODEPARTICIPANTE    = s.CODIGODEPARTICIPANTE    ,
                 t.CODIGODELOCAL           = s.CODIGODELOCAL           ,
                 t.FECHATRANSACCION_CAB    = s.FECHATRANSACCION_CAB    ,
                 t.HORATRANSACCION_CAB     = s.HORATRANSACCION_CAB     ,
                 t.HORATRANSSECCION_CAB    = s.HORATRANSSECCION_CAB    ,
                 t.NROPOS                  = s.NROPOS                  ,
                 t.NROTRNPOS               = s.NROTRNPOS               ,
                 t.MONTOTOTAL              = s.MONTOTOTAL              ,
                 t.SIGNO_MT                = s.SIGNO_MT                ,
                 t.MONTOTOTALNUM           = s.MONTOTOTALNUM           ,
                 t.PTOSACUMULADOS          = s.PTOSACUMULADOS          ,
                 t.SIGNO_PA                = s.SIGNO_PA                ,
                 t.PTOSACUMULADOSNUM       = s.PTOSACUMULADOSNUM       ,
                 t.FECHAASIGNACION_CAB     = s.FECHAASIGNACION_CAB     ,
                 t.CODIGODEPROMOCION       = s.CODIGODEPROMOCION       ,
                 t.DESCRIPCION_PRM         = s.DESCRIPCION_PRM         ,
                 t.TIPODETRANSACCION       = s.TIPODETRANSACCION       ,
                 t.NOMBREDEALER            = s.NOMBREDEALER            ,
                 t.IDTRX                   = s.IDTRX                   ,
                 t.SEC                     = s.SEC                     ,
                 t.PLU                     = s.PLU                     ,
                 t.CANTIDAD                = s.CANTIDAD                ,
                 t.CANTIDADNUM             = s.CANTIDADNUM             ,
                 t.MONTOPARCIAL            = s.MONTOPARCIAL            ,
                 t.SIGNO_MP                = s.SIGNO_MP                ,
                 t.MONTOPARCIALNUM         = s.MONTOPARCIALNUM         ,
                 t.RE_UNDECO               = s.RE_UNDECO               ,
                 t.SAP_CONTRATO            = s.SAP_CONTRATO            ,
                 t.DESCRIPCIONTDA          = s.DESCRIPCIONTDA          ,
                 t.USUARIO                 = s.USUARIO                 ,
                 t.CATEGORIA               = s.CATEGORIA               ,
                 t.SUBCATEGORIA            = s.SUBCATEGORIA            ,
                 t.FEC_ACT                 = CONCAT(@date,@hora)       ,
                 t.CNT_C_A                 = t.CNT_C_A + 1
    WHEN NOT MATCHED THEN
      INSERT ( CODIGOPERSONA           ,
               NUMTARJETABONUS         ,
               TIPOTARJETA             ,
               CODIGOTIPOPERSONA       ,
               CODIGOTIPOPERSONA_D     ,
               TIPODEDOCUMENTO         ,
               TIPODEDOCUMENTO_D       ,
               NRODOCUMENTO            ,
               NRORUC                  ,
               NOMBRES                 ,
               APELLIDOPATERNO         ,
               APELLIDOMATERNO         ,
               FECHANACIMIENTO         ,
               EDAD                    ,
               EDAD_RANGO              ,
               SEXO_TIT                ,
               SEXO_TIT_D              ,
               FLAGESTADOCIVIL         ,
               FLAGESTADOCIVIL_D       ,
               FLAGTIENEHIJOS          ,
               FLAGTIENEHIJOS_D        ,
               FLAGTIENETELEFONO       ,
               FLAGTIENETELEFONO_D     ,
               FLAGTIENECORREO         ,
               FLAGTIENECORREO_D       ,
               FLAGCOMPARTEDATOS       ,
               FLAGCOMPARTEDATOS_D     ,
               FLAGAUTCANJE            ,
               FLAGAUTCANJE_D          ,
               FLAGCLTEFALLECIDO       ,
               FLAGCLTEFALLECIDO_D     ,
               RAZONSOCIAL             ,
               FECHACREACION_PER       ,
               HORACREACION_PER        ,
               FECHAULTMODIF_PER       ,
               FECHACARGAINICIAL_PER   ,
               FECHACARGAULTMODIF_PER  ,
               CODPOS                  ,
               DIRECCION               ,
               DEPARTAMENTO            ,
               PROVINCIA               ,
               DISTRITO                ,
               FLAGULTIMO_DIR          ,
               REFERENCIA              ,
               ESTADO                  ,
               ESTADO_D                ,
               COORDENADAX             ,
               COORDENADAY             ,
               FLAGCOORDENADA          ,
               NSE                     ,
               TELEFONO                ,
               TELEFONO_D              ,
               FECHACREACION_TEL       ,
               EMAIL                   ,
               FECHACREACION_EML       ,
               HIJ_AS                  ,
               HIJ_OS                  ,
               HIJ_NN                  ,
               HIJ_TOT                 ,
               CODIGODEPARTICIPANTE    ,
               CODIGODELOCAL           ,
               FECHATRANSACCION_CAB    ,
               HORATRANSACCION_CAB     ,
               HORATRANSSECCION_CAB    ,
               NROPOS                  ,
               NROTRNPOS               ,
               MONTOTOTAL              ,
               SIGNO_MT                ,
               MONTOTOTALNUM           ,
               PTOSACUMULADOS          ,
               SIGNO_PA                ,
               PTOSACUMULADOSNUM       ,
               FECHAASIGNACION_CAB     ,
               CODIGODEPROMOCION       ,
               DESCRIPCION_PRM         ,
               TIPODETRANSACCION       ,
               NOMBREDEALER            ,
               IDTRX                   ,
               SEC                     ,
               PLU                     ,
               CANTIDAD                ,
               CANTIDADNUM             ,
               MONTOPARCIAL            ,
               SIGNO_MP                ,
               MONTOPARCIALNUM         ,
               RE_UNDECO               ,
               SAP_CONTRATO            ,
               DESCRIPCIONTDA          ,
               USUARIO                 ,
               CATEGORIA               ,
               SUBCATEGORIA            ,
               FEC_CRE                 ,
               CNT_C_A )
      VALUES ( s.CODIGOPERSONA           ,
               s.NUMTARJETABONUS         ,
               s.TIPOTARJETA             ,
               s.CODIGOTIPOPERSONA       ,
               s.CODIGOTIPOPERSONA_D     ,
               s.TIPODEDOCUMENTO         ,
               s.TIPODEDOCUMENTO_D       ,
               s.NRODOCUMENTO            ,
               s.NRORUC                  ,
               s.NOMBRES                 ,
               s.APELLIDOPATERNO         ,
               s.APELLIDOMATERNO         ,
               s.FECHANACIMIENTO         ,
               s.EDAD                    ,
               s.EDAD_RANGO              ,
               s.SEXO_TIT                ,
               s.SEXO_TIT_D              ,
               s.FLAGESTADOCIVIL         ,
               s.FLAGESTADOCIVIL_D       ,
               s.FLAGTIENEHIJOS          ,
               s.FLAGTIENEHIJOS_D        ,
               s.FLAGTIENETELEFONO       ,
               s.FLAGTIENETELEFONO_D     ,
               s.FLAGTIENECORREO         ,
               s.FLAGTIENECORREO_D       ,
               s.FLAGCOMPARTEDATOS       ,
               s.FLAGCOMPARTEDATOS_D     ,
               s.FLAGAUTCANJE            ,
               s.FLAGAUTCANJE_D          ,
               s.FLAGCLTEFALLECIDO       ,
               s.FLAGCLTEFALLECIDO_D     ,
               s.RAZONSOCIAL             ,
               s.FECHACREACION_PER       ,
               s.HORACREACION_PER        ,
               s.FECHAULTMODIF_PER       ,
               s.FECHACARGAINICIAL_PER   ,
               s.FECHACARGAULTMODIF_PER  ,
               s.CODPOS                  ,
               s.DIRECCION               ,
               s.DEPARTAMENTO            ,
               s.PROVINCIA               ,
               s.DISTRITO                ,
               s.FLAGULTIMO_DIR          ,
               s.REFERENCIA              ,
               s.ESTADO                  ,
               s.ESTADO_D                ,
               s.COORDENADAX             ,
               s.COORDENADAY             ,
               s.FLAGCOORDENADA          ,
               s.NSE                     ,
               s.TELEFONO                ,
               s.TELEFONO_D              ,
               s.FECHACREACION_TEL       ,
               s.EMAIL                   ,
               s.FECHACREACION_EML       ,
               s.HIJ_AS                  ,
               s.HIJ_OS                  ,
               s.HIJ_NN                  ,
               s.HIJ_TOT                 ,
               s.CODIGODEPARTICIPANTE    ,
               s.CODIGODELOCAL           ,
               s.FECHATRANSACCION_CAB    ,
               s.HORATRANSACCION_CAB     ,
               s.HORATRANSSECCION_CAB    ,
               s.NROPOS                  ,
               s.NROTRNPOS               ,
               s.MONTOTOTAL              ,
               s.SIGNO_MT                ,
               s.MONTOTOTALNUM           ,
               s.PTOSACUMULADOS          ,
               s.SIGNO_PA                ,
               s.PTOSACUMULADOSNUM       ,
               s.FECHAASIGNACION_CAB     ,
               s.CODIGODEPROMOCION       ,
               s.DESCRIPCION_PRM         ,
               s.TIPODETRANSACCION       ,
               s.NOMBREDEALER            ,
               s.IDTRX                   ,
               s.SEC                     ,
               s.PLU                     ,
               s.CANTIDAD                ,
               s.CANTIDADNUM             ,
               s.MONTOPARCIAL            ,
               s.SIGNO_MP                ,
               s.MONTOPARCIALNUM         ,
               s.RE_UNDECO               ,
               s.SAP_CONTRATO            ,
               s.DESCRIPCIONTDA          ,
               s.USUARIO                 ,
               s.CATEGORIA               ,
               s.SUBCATEGORIA            ,
               CONCAT(@date,@hora)       ,
               1 );

--tablon MKT

TRUNCATE TABLE bds.TABLON_MKT;

INSERT INTO bds.TABLON_MKT
SELECT ANO
      ,MES
  --  ,DESCRIPCION_PRM
  --  ,NOMBREDEALER
      ,RE_UNDECO
  --  ,DESCRIPCIONTDA
  --  ,CATEGORIA
  --  ,SUBCATEGORIA
      ,COUNT(*) AS CANT
      ,CODIGOTIPOPERSONA_D
      ,TIPODEDOCUMENTO_D
      ,NRODOCUMENTO
      ,NRORUC
      ,NOMBRES
      ,APELLIDOPATERNO
      ,APELLIDOMATERNO
      ,fechanacimiento
      ,SEXO_TIT_D
      ,FLAGESTADOCIVIL_D
      ,FLAGTIENEHIJOS_D
      ,FLAGTIENETELEFONO_D
      ,FLAGTIENECORREO_D
      ,FLAGCOMPARTEDATOS_D
      ,FLAGAUTCANJE_D
      ,FLAGCLTEFALLECIDO_D
      ,RAZONSOCIAL
      ,CODPOS
      ,DIRECCION
      ,DEPARTAMENTO
      ,PROVINCIA
      ,DISTRITO
      ,REFERENCIA
      ,ESTADO_D
      ,COORDENADAX
      ,COORDENADAY
      ,FLAGCOORDENADA
      ,NSE
      ,TELEFONO
      ,TELEFONO_D
      ,FECHACREACION_TEL
      ,EMAIL
      ,FECHACREACION_EML
      ,HIJ_AS
      ,HIJ_OS
      ,HIJ_NN
      ,HIJ_TOT 
FROM ( SELECT DISTINCT
            SUBSTRING(FECHATRANSACCION_CAB,1,4) AS ANO
           ,SUBSTRING(FECHATRANSACCION_CAB,5,2) AS MES
       --	,DESCRIPCION_PRM
       --	,NOMBREDEALER
           ,RE_UNDECO
       --	,DESCRIPCIONTDA
       --	,CATEGORIA
       --	,SUBCATEGORIA
	       ,CODIGOTIPOPERSONA_D
	       ,TIPODEDOCUMENTO_D
	       ,NRODOCUMENTO
	       ,NRORUC
	       ,NOMBRES
	       ,APELLIDOPATERNO
	       ,APELLIDOMATERNO
		   ,fechanacimiento
	       ,SEXO_TIT_D
	       ,FLAGESTADOCIVIL_D
	       ,FLAGTIENEHIJOS_D
	       ,FLAGTIENETELEFONO_D
	       ,FLAGTIENECORREO_D
	       ,FLAGCOMPARTEDATOS_D
	       ,FLAGAUTCANJE_D
	       ,FLAGCLTEFALLECIDO_D
	       ,RAZONSOCIAL
	       ,CODPOS
	       ,DIRECCION
	       ,DEPARTAMENTO
	       ,PROVINCIA
	       ,DISTRITO
	       ,REFERENCIA
	       ,ESTADO_D
	       ,COORDENADAX
	       ,COORDENADAY
	       ,FLAGCOORDENADA
	       ,NSE
	       ,TELEFONO
	       ,TELEFONO_D
	       ,FECHACREACION_TEL
	       ,EMAIL
	       ,FECHACREACION_EML
	       ,HIJ_AS
	       ,HIJ_OS
	       ,HIJ_NN
	       ,HIJ_TOT
           ,IDTRX 
       FROM bds.TABLON
       WHERE CODIGOPERSONA <> '0000000000' ) AS T
GROUP BY ANO
        ,MES
    --   ,DESCRIPCION_PRM
    --	 ,NOMBREDEALER
        ,RE_UNDECO
    --	 ,DESCRIPCIONTDA
    --	 ,CATEGORIA
    --	 ,SUBCATEGORIA
        ,CODIGOTIPOPERSONA_D
        ,TIPODEDOCUMENTO_D
        ,NRODOCUMENTO
        ,NRORUC
        ,NOMBRES
        ,APELLIDOPATERNO
        ,APELLIDOMATERNO
		,fechanacimiento
        ,SEXO_TIT_D
        ,FLAGESTADOCIVIL_D
        ,FLAGTIENEHIJOS_D
        ,FLAGTIENETELEFONO_D
        ,FLAGTIENECORREO_D
        ,FLAGCOMPARTEDATOS_D
        ,FLAGAUTCANJE_D
        ,FLAGCLTEFALLECIDO_D
        ,RAZONSOCIAL
        ,CODPOS
        ,DIRECCION
        ,DEPARTAMENTO
        ,PROVINCIA
        ,DISTRITO
        ,REFERENCIA
        ,ESTADO_D
        ,COORDENADAX
        ,COORDENADAY
        ,FLAGCOORDENADA
        ,NSE
        ,TELEFONO
        ,TELEFONO_D
        ,FECHACREACION_TEL
        ,EMAIL
        ,FECHACREACION_EML
        ,HIJ_AS
        ,HIJ_OS
        ,HIJ_NN
        ,HIJ_TOT 
ORDER BY ANO
        ,MES
        ,CODIGOTIPOPERSONA_D
        ,NRODOCUMENTO
        ,NRORUC ;

END
GO