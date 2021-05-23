SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [ctl].[main_auto]
AS
BEGIN

    DECLARE @nTxt TINYINT,
    		@nZip TINYINT;
    
    SET @nTxt = (SELECT SIGN(COUNT(*)) FROM ctl.wrk04 WHERE UPPER(extension) = 'TXT');
    SET @nZip = (SELECT SIGN(COUNT(*)) FROM ctl.wrk04 WHERE UPPER(extension) = 'ZIP');

    BEGIN
        
        --stg
        IF @nZip > 0
            BEGIN
                EXEC stg.carga_maestros;
                PRINT('stg_zip>0');
            END
        IF @nTxt > 0
            BEGIN
                EXEC stg.carga_transacciones;
                PRINT('stg_txt>0');
            END

        --ods
        IF @nZip > 0
            BEGIN
                EXEC ods.carga_maestros;
                PRINT('ods_zip>0');
            END
        IF @nTxt > 0
            BEGIN
                EXEC ods.carga_transacciones;
                PRINT('ods_txt>0');
            END

        --bds
        IF @nZip > 0
            BEGIN
                EXEC ods.carga_clientes;
                PRINT('bds_txt>0');
            END

        EXEC ods.carga_tablon;

    END

    --inserta en ctl.control los nuevos archivos que se han procesado
    EXEC ctl.ctl02_post;

END
GO