SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [ods].[carga_maestros]
AS
  /***************************************************************************************************
  Procedure:          ods.carga_maestros
  Create Date:        202006DD
  Author:             dÁlvarez
  Description:        carga maestros de BONUS
  Call by:            tbd
  Affected table(s):  maestros
  Used By:            BI
  Parameter(s):       none
  Log:                none
  Prerequisites:      tbd
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  202006DD            dÁlvarez            creación
  20210523            dÁlvarez            cleansing coordenadas 
  
  ***************************************************************************************************/

BEGIN

DECLARE @date NVARCHAR(8),
		@hora NVARCHAR(8);

SET @date = (select date from ctl.wrk01);
SET @hora = (select hora from ctl.wrk02);

--truncates

truncate table ods.W1_PERSONA       ;
truncate table bds.PERSONA          ;
truncate table ods.W4_03_CLTUNIF_TXT;
truncate table bds.UNIF             ;
truncate table bds.DIRECCION        ;
truncate table bds.EMAIL            ;
truncate table bds.HIJO             ;
truncate table bds.TELEFONO         ;
truncate table bds.CONTACTO         ;


--persona

INSERT INTO ods.W1_PERSONA
SELECT CODIGOPERSONA      , CODIGOTIPOPERSONA, TIPODEDOCUMENTO, NRODOCUMENTO,
       --PN
       NULL AS NRORUC             ,
       NULL AS NOMBRES            ,
       NULL AS APELLIDOPATERNO    ,
       NULL AS APELLIDOMATERNO    ,
       NULL AS FECHANACIMIENTO    ,
       NULL AS SEXO_TIT           ,
       NULL AS FLAGESTADOCIVIL    ,
       NULL AS FLAGTIENEHIJOS     ,
       NULL AS FLAGTIENETELEFONO  ,
       NULL AS FLAGTIENECORREO    ,
       NULL AS FLAGCOMPARTEDATOS  ,
       NULL AS FLAGAUTCANJE       ,
       NULL AS FLAGCLTEFALLECIDO  ,
       --PJ
       RAZONSOCIAL,
       FECHACREACIONS01   AS FECHACREACION_PER,
       HORACREACIONS01    AS HORACREACION_PER,
       FECHAULTMODIFS01   AS FECHAULTMODIF_PER
  FROM ods.W2_01_CLTE_PJ_TXT
 UNION ALL
SELECT CODIGOPERSONA      , CODIGOTIPOPERSONA, TIPODEDOCUMENTO, NRODOCUMENTO,
       --PN
       NRORUC             ,
       NOMBRES            ,
       APELLIDOPATERNO    ,
       APELLIDOMATERNO    ,
       FECHANACIMIENTO    ,
       SEXO_TIT           ,
       FLAGESTADOCIVIL    ,
       FLAGTIENEHIJOS     ,
       FLAGTIENETELEFONO  ,
       FLAGTIENECORREO    ,
       FLAGCOMPARTEDATOS  ,
       FLAGAUTCANJE       ,
       FLAGCLTEFALLECIDO  ,
       --PJ
       NULL AS RAZONSOCIAL,
       FECHACREACIONS02 AS FECHACREACION_PER,
       HORACREACIONS02  AS HORACREACION_PER,
       FECHAULTMODIFS02 AS FECHAULTMODIF_PER
  FROM ods.W2_02_CLTE_PN_TXT;

/* desarrollo control deltas tablas CONTACTO, DIRECCION, EMAIL, HIJO, PERSONA, TELEFONO, UNIF

tablas: CONTACTO_E, DIRECCION_E, EMAIL_E, HIJO_E, PERSONA_E, TELEFONO_E, UNIF_E guarda el delta del bds y ods
tablas: CONTACTO_I, DIRECCION_I, EMAIL_I, HIJO_I, PERSONA_I, TELEFONO_I, UNIF_I No a usar (borrar)

INSERT INTO ods.PERSONA
SELECT T.CODIGOPERSONA    ,
       T.NUMTARJETABONUS  ,
       T.TIPOTARJETA      ,
       P.CODIGOTIPOPERSONA,
       P.TIPODEDOCUMENTO  ,
       P.NRODOCUMENTO     ,
       P.NRORUC           ,
       P.NOMBRES          ,
       P.APELLIDOPATERNO  ,
       P.APELLIDOMATERNO  ,
       (CASE WHEN P.FECHANACIMIENTO < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(P.FECHANACIMIENTO)<>8 THEN '20201010' ELSE P.FECHANACIMIENTO END) END) AS FECHANACIMIENTO,  --wa
       P.SEXO_TIT         ,
       P.FLAGESTADOCIVIL  ,
       P.FLAGTIENEHIJOS   ,
       P.FLAGTIENETELEFONO,
       P.FLAGTIENECORREO  ,
       P.FLAGCOMPARTEDATOS,
       P.FLAGAUTCANJE     ,
       P.FLAGCLTEFALLECIDO,
       P.RAZONSOCIAL      ,
       (CASE WHEN P.FECHACREACION_PER < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(P.FECHACREACION_PER)<>8 THEN '20201010' ELSE P.FECHACREACION_PER END) END) AS FECHACREACION_PER,  --wa,
       P.HORACREACION_PER ,
       (CASE WHEN P.FECHAULTMODIF_PER < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(P.FECHAULTMODIF_PER)<>8 THEN '20201010' ELSE P.FECHAULTMODIF_PER END) END) AS FECHAULTMODIF_PER,  --wa,
       @date as fecha,
       ''
  FROM ods.W2_08_TARJETA_TXT AS T 
         INNER JOIN ods.W1_PERSONA AS P ON T.CODIGOPERSONA = P.CODIGOPERSONA;

-----
INSERT INTO ods.PERSONA_E(
       CODIGOPERSONA    ,
       NUMTARJETABONUS  ,
       TIPOTARJETA      ,
       CODIGOTIPOPERSONA,
       TIPODEDOCUMENTO  ,
       NRODOCUMENTO     ,
       NRORUC           ,
       NOMBRES          ,
       APELLIDOPATERNO  ,
       APELLIDOMATERNO  ,
       FECHANACIMIENTO  ,
       SEXO_TIT         ,
       FLAGESTADOCIVIL  ,
       FLAGTIENEHIJOS   ,
       FLAGTIENETELEFONO,
       FLAGTIENECORREO  ,
       FLAGCOMPARTEDATOS,
       FLAGAUTCANJE     ,
       FLAGCLTEFALLECIDO,
       RAZONSOCIAL      ,
       FECHACREACION_PER,
       HORACREACION_PER ,
       FECHAULTMODIF_PER)
SELECT CODIGOPERSONA    ,
       NUMTARJETABONUS  ,
       TIPOTARJETA      ,
       CODIGOTIPOPERSONA,
       TIPODEDOCUMENTO  ,
       NRODOCUMENTO     ,
       NRORUC           ,
       NOMBRES          ,
       APELLIDOPATERNO  ,
       APELLIDOMATERNO  ,
       FECHANACIMIENTO  ,
       SEXO_TIT         ,
       FLAGESTADOCIVIL  ,
       FLAGTIENEHIJOS   ,
       FLAGTIENETELEFONO,
       FLAGTIENECORREO  ,
       FLAGCOMPARTEDATOS,
       FLAGAUTCANJE     ,
       FLAGCLTEFALLECIDO,
       RAZONSOCIAL      ,
       FECHACREACION_PER,
       HORACREACION_PER ,
       FECHAULTMODIF_PER
  FROM bds.PERSONA
EXCEPT
SELECT CODIGOPERSONA    ,
       NUMTARJETABONUS  ,
       TIPOTARJETA      ,
       CODIGOTIPOPERSONA,
       TIPODEDOCUMENTO  ,
       NRODOCUMENTO     ,
       NRORUC           ,
       NOMBRES          ,
       APELLIDOPATERNO  ,
       APELLIDOMATERNO  ,
       FECHANACIMIENTO  ,
       SEXO_TIT         ,
       FLAGESTADOCIVIL  ,
       FLAGTIENEHIJOS   ,
       FLAGTIENETELEFONO,
       FLAGTIENECORREO  ,
       FLAGCOMPARTEDATOS,
       FLAGAUTCANJE     ,
       FLAGCLTEFALLECIDO,
       RAZONSOCIAL      ,
       FECHACREACION_PER,
       HORACREACION_PER ,
       FECHAULTMODIF_PER
  FROM ods.PERSONA;

------
*/

INSERT INTO bds.PERSONA
SELECT T.CODIGOPERSONA    ,
       T.NUMTARJETABONUS  ,
       T.TIPOTARJETA      ,
       P.CODIGOTIPOPERSONA,
       P.TIPODEDOCUMENTO  ,
       P.NRODOCUMENTO     ,
       P.NRORUC           ,
       P.NOMBRES          ,
       P.APELLIDOPATERNO  ,
       P.APELLIDOMATERNO  ,
       (CASE WHEN P.FECHANACIMIENTO < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(P.FECHANACIMIENTO)<>8 THEN '20201010' ELSE P.FECHANACIMIENTO END) END) AS FECHANACIMIENTO,  --wa
       P.SEXO_TIT         ,
       P.FLAGESTADOCIVIL  ,
       P.FLAGTIENEHIJOS   ,
       P.FLAGTIENETELEFONO,
       P.FLAGTIENECORREO  ,
       P.FLAGCOMPARTEDATOS,
       P.FLAGAUTCANJE     ,
       P.FLAGCLTEFALLECIDO,
       P.RAZONSOCIAL      ,
       (CASE WHEN P.FECHACREACION_PER < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(P.FECHACREACION_PER)<>8 THEN '20201010' ELSE P.FECHACREACION_PER END) END) AS FECHACREACION_PER,  --wa,
       P.HORACREACION_PER ,
       (CASE WHEN P.FECHAULTMODIF_PER < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(P.FECHAULTMODIF_PER)<>8 THEN '20201010' ELSE P.FECHAULTMODIF_PER END) END) AS FECHAULTMODIF_PER,  --wa,
       @date as fecha,
       '20200825'
  FROM ods.W2_08_TARJETA_TXT AS T 
         INNER JOIN ods.W1_PERSONA AS P ON T.CODIGOPERSONA = P.CODIGOPERSONA;

--otros

INSERT INTO ods.W4_03_CLTUNIF_TXT
SELECT IDPROCESO          ,
       PERSONAORIGEN      ,
       CUENTAORIGEN       ,
       PERSONADESTINO     ,
       CUENTADESTINO      ,
       TIPODEOPERACION    ,
       USUARIODEREGISTRO  ,
       (CASE WHEN FECHADEREGISTROS03 < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(FECHADEREGISTROS03)<>8 THEN '20201010' ELSE FECHADEREGISTROS03 END) END) AS FECHADEREGISTROS03,  --wa,
       @date as fecha,
       '20200825'
  FROM ods.W3_03_CLTUNIF_TXT;

INSERT INTO bds.UNIF
SELECT IDPROCESO,
       PERSONAORIGEN,
       CUENTAORIGEN,
       PERSONADESTINO,
       CUENTADESTINO,
       TIPODEOPERACION,
       USUARIODEREGISTRO,
       (SUBSTRING(FECHADEREGISTRO_UNI,1,10)+' '+SUBSTRING(FECHADEREGISTRO_UNI,12,2)+':'+SUBSTRING(FECHADEREGISTRO_UNI,15,2)+':'+SUBSTRING(FECHADEREGISTRO_UNI,18,2)) AS FECHADEREGISTRO_UNI,
       FECHACARGAINICIAL_UNI,
       FECHACARGAULTMODIF_UNI
  FROM ods.W4_03_CLTUNIF_TXT;

INSERT INTO bds.DIRECCION
SELECT CODIGOPERSONA          ,
       CODPOS                 ,
       DIRECCION              ,
       DEPARTAMENTO           ,
       PROVINCIA              ,
       DISTRITO               ,
       NULL AS FLAGULTIMO_DIR ,
       REFERENCIA             ,
       ESTADO                 ,
       (CASE WHEN TRY_CONVERT(float, COORDENADAX) is not null THEN COORDENADAX ELSE NULL END) AS COORDENADAX, --wa
       (CASE WHEN TRY_CONVERT(float, COORDENADAY) is not null THEN COORDENADAY ELSE NULL END) AS COORDENADAY, --wa
       NSE                    ,
       @date as fecha,
       '20200825'
  FROM ods.W3_04_DIRECC_TXT;

/*INI cleansing coordenadas

--https://es.wikipedia.org/wiki/Anexo:Puntos_extremos_del_Per%C3%BA
Punto extremo nor: 00°01′48″S 75°10′29″O.1​  En decimal	-0.03°, -75.174722°
Punto extremo sur: 18°21′08″S 70°22′39″O.1​  En decimal	-18.352222°, -70.3775°
Punto extremo est: 12°30′11″S 68°39′27″O1​   En decimal	-12.503056°, -68.6575°
Punto extremo oes: 04°40′45″S 81°19′35″O    En decimal	-4.679167°, -81.326389°

               -0.03°
                  |
                  |
-81.326389° ------------- -68.6575°
                  |
                  |
              -18.352222°
*/

UPDATE bds.DIRECCION
  SET COORDENADAX = NULL, COORDENADAY = NULL
WHERE COORDENADAX = COORDENADAY
  AND COORDENADAY IS NOT NULL;

UPDATE bds.DIRECCION
SET COORDENADAX = COORDENADAY, COORDENADAY = COORDENADAX
  WHERE CONVERT(FLOAT, COORDENADAX) < -18.352222 OR CONVERT(FLOAT, COORDENADAX) > -0.03
    AND (    CONVERT(FLOAT, COORDENADAY) >= -18.352222 OR CONVERT(FLOAT, COORDENADAX) <= -0.03
         AND CONVERT(FLOAT, COORDENADAY) >= -81.326389 OR CONVERT(FLOAT, COORDENADAY) <= -68.6575);

UPDATE bds.DIRECCION
SET COORDENADAX = COORDENADAY, COORDENADAY = COORDENADAX
  WHERE CONVERT(FLOAT, COORDENADAY) < -81.326389 OR CONVERT(FLOAT, COORDENADAY) > -68.6575
    AND (    CONVERT(FLOAT, COORDENADAY) >= -18.352222 OR CONVERT(FLOAT, COORDENADAX) <= -0.03
         AND CONVERT(FLOAT, COORDENADAY) >= -81.326389 OR CONVERT(FLOAT, COORDENADAY) <= -68.6575);

UPDATE bds.DIRECCION
  SET COORDENADAX = NULL, COORDENADAY = NULL
  WHERE CONVERT(FLOAT, COORDENADAX) < -18.352222 OR CONVERT(FLOAT, COORDENADAX) > -0.03;


UPDATE bds.DIRECCION
  SET COORDENADAX = NULL, COORDENADAY = NULL
  WHERE CONVERT(FLOAT, COORDENADAY) < -81.326389 OR CONVERT(FLOAT, COORDENADAY) > -68.6575;

--FIN cleansing coordenadas


INSERT INTO bds.EMAIL
SELECT CODIGOPERSONA    ,
       EMAILS05         ,
       NULL AS FLAGULTIMO_EML,
       (CASE WHEN FECHACREACIONS05 < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(FECHACREACIONS05)<>8 THEN '20201010' ELSE FECHACREACIONS05 END) END) AS FECHACREACIONS05,  --wa,
       @date as fecha,
       '20200825',
       orden
  FROM ods.W4_05_EMAIL_TXT;

INSERT INTO bds.HIJO
SELECT CODIGOPERSONA   ,
       SEXO_HIJ        ,
       (CASE WHEN FECHANACIMIENTO < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(FECHANACIMIENTO)<>8 THEN '20201010' ELSE FECHANACIMIENTO END) END) AS FECHANACIMIENTO,  --wa,
       @date as fecha,
       '20200825'
  FROM ods.W3_07_HIJOS_TXT;

INSERT INTO bds.TELEFONO
SELECT CODIGOPERSONA            ,
       TELEFONOS09              ,
       NULL AS FLAGULTIMO_TEL   ,
       (CASE WHEN FECHACREACIONS09 < '19000101' THEN '19000101' ELSE (CASE WHEN LEN(FECHACREACIONS09)<>8 THEN '20201010' ELSE FECHACREACIONS09 END) END) AS FECHACREACIONS09,  --wa,
       @date as fecha,
       '20200825',
       orden
  FROM ods.W4_09_TELEF_TXT;

INSERT INTO bds.CONTACTO
SELECT CODIGOPERSONA    ,
       'EMAIL' AS CANAL ,
       EMAILS06  AS CONTACTO,
       FLAGCONTACTOS06  AS FLAGCONTACTO_NOC,
       @date as fecha,
       '20200825'
  FROM ods.W3_06_EMANOCON_TXT
 UNION ALL
SELECT CODIGOPERSONA ,
       'TELEFONO' AS CANAL ,
       TELEFONOS10  AS CONTACTO,
       FLAGCONTACTOS10  AS FLAGCONTACTO_NOC,
       @date as fecha,
       '20200825'
  FROM ods.W3_10_TLFNOCON_TXT;


--historia maestros

--el 20201020 se cargo en la historia el ultimo lote de archivos maestros nuevamente
--para corregir el error en la codificación del bulk

INSERT INTO ctl.HPERSONA    SELECT *, @date, @hora FROM bds.PERSONA    ;
INSERT INTO ctl.HUNIF       SELECT *, @date, @hora FROM bds.UNIF       ;
INSERT INTO ctl.HDIRECCION  SELECT *, @date, @hora FROM bds.DIRECCION  ;
INSERT INTO ctl.HEMAIL      SELECT *, @date, @hora FROM bds.EMAIL      ;
INSERT INTO ctl.HHIJO       SELECT *, @date, @hora FROM bds.HIJO       ;
INSERT INTO ctl.HTELEFONO   SELECT *, @date, @hora FROM bds.TELEFONO   ;
INSERT INTO ctl.HCONTACTO   SELECT *, @date, @hora FROM bds.CONTACTO   ;

END
GO