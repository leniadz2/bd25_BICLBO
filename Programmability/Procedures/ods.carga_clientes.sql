SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [ods].[carga_clientes]
AS
  /***************************************************************************************************
  Procedure:          ods.carga_clientes
  Create Date:        202006DD
  Author:             dÁlvarez
  Description:        carga tabla de clientes de BONUS
  Call by:            tbd
  Affected table(s):  bds.CLIENTES
                      bds.HIJOS
  Used By:            BI
  Parameter(s):       none
  Log:                none
  Prerequisites:      carga de los maestros
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  202006DD            dÁlvarez            creación
  20210523            dÁlvarez            tipo telefono 
  
  ***************************************************************************************************/

BEGIN

DECLARE @date NVARCHAR(8),
		@hora NVARCHAR(8);

SET @date = (select date from ctl.wrk01);
SET @hora = (select hora from ctl.wrk02);

--truncate 2do grupo
truncate table bds.HIJOS    ;
truncate table bds.CLIENTES ;


INSERT INTO bds.HIJOS
SELECT T.CODIGOPERSONA,
       SUM(T.FEMENINO) AS FEMENINO,
       SUM(T.MASCULINO) AS MASCULINO,
       SUM(T.NN) AS NN
  FROM ( SELECT CODIGOPERSONA, 
                IIF(SEXO_HIJ='1',1,0) AS FEMENINO,
                IIF(SEXO_HIJ='2',1,0) AS MASCULINO,
                IIF(SEXO_HIJ='0',1,0) AS NN
           FROM bds.HIJO) AS T
 GROUP BY T.CODIGOPERSONA;


INSERT INTO bds.CLIENTES (
	 CODIGOPERSONA
	,ORDTARJETABONUS
	,NUMTARJETABONUS
	,TIPOTARJETA
	,CODIGOTIPOPERSONA
	,CODIGOTIPOPERSONA_D
	,TIPODEDOCUMENTO
	,TIPODEDOCUMENTO_D
	,NRODOCUMENTO
	,NRORUC
	,NOMBRES
	,APELLIDOPATERNO
	,APELLIDOMATERNO
	,FECHANACIMIENTO
	,EDAD
	,EDAD_RANGO
	,SEXO_TIT
	,SEXO_TIT_D
	,FLAGESTADOCIVIL
	,FLAGESTADOCIVIL_D
	,FLAGTIENEHIJOS
	,FLAGTIENEHIJOS_D
	,FLAGTIENETELEFONO
	,FLAGTIENETELEFONO_D
	,FLAGTIENECORREO
	,FLAGTIENECORREO_D
	,FLAGCOMPARTEDATOS
	,FLAGCOMPARTEDATOS_D
	,FLAGAUTCANJE
	,FLAGAUTCANJE_D
	,FLAGCLTEFALLECIDO
	,FLAGCLTEFALLECIDO_D
	,RAZONSOCIAL
	,FECHACREACION_PER
	,HORACREACION_PER
	,FECHAULTMODIF_PER
	,FECHACARGAINICIAL_PER
	,FECHACARGAULTMODIF_PER
	,CODPOS
	,DIRECCION
	,DEPARTAMENTO
	,PROVINCIA
	,DISTRITO
	,FLAGULTIMO_DIR
	,REFERENCIA
	,ESTADO
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
	)
VALUES (
	 '0000000000'
	,0
	,'0000000000000000000'
	,'SIN DESCRIPCION'
	,'XX'
	,'XXXXXXXX'
	,'XXXX'
	,'XXXX'
	,'XXXXXXXX'
	,'XXXXXXXXXXX'
	,'SIN DESCRIPCION'
	,'SIN DESCRIPCION'
	,'SIN DESCRIPCION'
	,'19000101'
	,0
	,'XX-XX'
	,'X'
	,'XXXXXXXXXXX'
	,'X'
	,'XXXXXXXXXXX'
	,'X'
	,'XX'
	,'X'
	,'XX'
	,'X'
	,'XX'
	,'X'
	,'XX'
	,'X'
	,'XX'
	,'X'
	,'XX'
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,'XXX'
	,'SIN DESCRIPCION'
	,'XXXX'
	,'XXXX'
	,'XXXX'
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,'0'
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	,NULL
	);


INSERT INTO bds.CLIENTES
SELECT p.CODIGOPERSONA           ,
       ROW_NUMBER() OVER (PARTITION BY p.CODIGOPERSONA ORDER BY p.numtarjetabonus DESC) as ORDTARJETABONUS,
       p.NUMTARJETABONUS         ,
       p.TIPOTARJETA             ,
       p.CODIGOTIPOPERSONA       ,
       IIF( p.CODIGOTIPOPERSONA = '01','Natural','Jurídica') as  CODIGOTIPOPERSONA_D,
       p.TIPODEDOCUMENTO         ,
       CASE
           WHEN p.TIPODEDOCUMENTO = '0001' THEN 'DNI'
           WHEN p.TIPODEDOCUMENTO = '0002' THEN 'CI'
           WHEN p.TIPODEDOCUMENTO = '0003' THEN 'CE'
           WHEN p.TIPODEDOCUMENTO = '0004' THEN 'PASAPORTE'
           WHEN p.TIPODEDOCUMENTO = '0005' THEN 'RUC'
           WHEN p.TIPODEDOCUMENTO = '0009' THEN 'SIN DOC-ID'
           ELSE 'Sin definir'
       END as  TIPODEDOCUMENTO_D,
       p.NRODOCUMENTO            ,
       p.NRORUC                  ,
       p.NOMBRES                 ,
       p.APELLIDOPATERNO         ,
       p.APELLIDOMATERNO         ,
       p.FECHANACIMIENTO         ,
       DATEDIFF(YY, CONVERT(DATETIME, p.FECHANACIMIENTO), GETDATE()) -
       CASE 
            WHEN DATEADD(YY,DATEDIFF(YY, CONVERT(DATETIME, p.FECHANACIMIENTO), GETDATE()),CONVERT(DATETIME, p.FECHANACIMIENTO)) > GETDATE() THEN 1
            ELSE 0
       END AS EDAD,
       CASE
           WHEN (2020 - LEFT(p.FECHANACIMIENTO,4)) < 18 THEN 'MENOR DE EDAD'
           WHEN (2020 - LEFT(p.FECHANACIMIENTO,4)) >= 18 AND (2020 - LEFT(p.FECHANACIMIENTO,4)) < 20 THEN '18-19'
           WHEN (2020 - LEFT(p.FECHANACIMIENTO,4)) >= 20 AND (2020 - LEFT(p.FECHANACIMIENTO,4)) < 30 THEN '20-29'
           WHEN (2020 - LEFT(p.FECHANACIMIENTO,4)) >= 30 AND (2020 - LEFT(p.FECHANACIMIENTO,4)) < 40 THEN '30-39'
           WHEN (2020 - LEFT(p.FECHANACIMIENTO,4)) >= 40 AND (2020 - LEFT(p.FECHANACIMIENTO,4)) < 50 THEN '40-49'
           WHEN (2020 - LEFT(p.FECHANACIMIENTO,4)) >= 50 AND (2020 - LEFT(p.FECHANACIMIENTO,4)) < 60 THEN '50-59'
           WHEN (2020 - LEFT(p.FECHANACIMIENTO,4)) >= 60 AND (2020 - LEFT(p.FECHANACIMIENTO,4)) < 70 THEN '60-69'
           WHEN (2020 - LEFT(p.FECHANACIMIENTO,4)) >= 70 AND (2020 - LEFT(p.FECHANACIMIENTO,4)) < 80 THEN '70-79'
           ELSE 'MAYORES DE 80'
       END as  EDAD_RANGO,
       p.SEXO_TIT                ,
       CASE
           WHEN p.SEXO_TIT = '1' THEN 'FEMENINO'
           WHEN p.SEXO_TIT = '2' THEN 'MASCULINO'
           WHEN p.SEXO_TIT = '0' THEN 'NN'
           ELSE 'Sin definir'
       END as  SEXO_TIT_D,
       p.FLAGESTADOCIVIL         ,
       CASE
           WHEN p.FLAGESTADOCIVIL = '1' THEN 'SOLTERO'
           WHEN p.FLAGESTADOCIVIL = '2' THEN 'CASADO'
           WHEN p.FLAGESTADOCIVIL = '3' THEN 'VIUDO'
           WHEN p.FLAGESTADOCIVIL = '4' THEN 'DIVORCIADO'
           ELSE 'Sin definir'
       END as  FLAGESTADOCIVIL_D,
       p.FLAGTIENEHIJOS          ,
       IIF( p.FLAGTIENEHIJOS = '0','NO','SÍ') as  FLAGTIENEHIJOS_D,
       p.FLAGTIENETELEFONO       ,
       IIF( p.FLAGTIENETELEFONO = '0','NO','SÍ') as  FLAGTIENETELEFONO_D,
       p.FLAGTIENECORREO         ,
       IIF( p.FLAGTIENECORREO = '0','NO','SÍ') as  FLAGTIENECORREO_D,
       p.FLAGCOMPARTEDATOS       ,
       IIF( p.FLAGCOMPARTEDATOS = '0','NO','SÍ') as  FLAGCOMPARTEDATOS_D,
       p.FLAGAUTCANJE            ,
       IIF( p.FLAGAUTCANJE = '0','NO','SÍ') as  FLAGAUTCANJE_D,
       p.FLAGCLTEFALLECIDO       ,
       IIF( p.FLAGCLTEFALLECIDO = '0','NO','SÍ') as  FLAGCLTEFALLECIDO_D,
       p.RAZONSOCIAL             ,
       p.FECHACREACION_PER       ,
       p.HORACREACION_PER        ,
       p.FECHAULTMODIF_PER       ,
       p.FECHACARGAINICIAL_PER   ,
       p.FECHACARGAULTMODIF_PER  ,
       d.CODPOS        ,
       d.DIRECCION     ,
       d.DEPARTAMENTO  ,
       d.PROVINCIA     ,
       d.DISTRITO      ,
       d.FLAGULTIMO_DIR,
       d.REFERENCIA    ,
       d.ESTADO        ,
       IIF( d.ESTADO = '0','ERRADO','OK') as  ESTADO_D,
       d.COORDENADAX   ,
       d.COORDENADAY   ,
       IIF(d.COORDENADAX is null,'0','1') as FLAGCOORDENADA,
       d.NSE,
       t.TELEFONO,
       CASE
           WHEN t.TELEFONO like  '09%' THEN 'CELULAR'
           WHEN t.TELEFONO IS NULL THEN NULL
           ELSE 'NO CELULAR'
       END as  TELEFONO_D,
       t.FECHACREACION_TEL,
       e.EMAIL,
       e.FECHACREACION_EML,
       h.FEMENINO as HIJ_AS,
       h.MASCULINO as HIJ_OS,
       h.NN as HIJ_NN,
       h.FEMENINO + h.FEMENINO + h.NN as HIJ_TOT
  from bds.persona as p
       left join bds.direccion as d on p.CODIGOPERSONA = d.CODIGOPERSONA
       left join bds.telefono as t on p.CODIGOPERSONA = t.CODIGOPERSONA and  t.orden = 1
       left join bds.email as e on p.CODIGOPERSONA = e.CODIGOPERSONA and e.orden = 1
       left join bds.hijos as h on p.CODIGOPERSONA = h.CODIGOPERSONA;

END
GO