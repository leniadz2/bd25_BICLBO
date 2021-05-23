SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [ctl].[ctl01_pre]
AS
BEGIN

DECLARE @vpar1 NVARCHAR(100);
DECLARE @ilen INT;

SET @vpar1 = (select value from ctl.parametros where id = '1');
SET @ilen  = len(@vpar1);

truncate table ctl.wrk04;

insert into ctl.wrk04
select filename, md5, substring(filename,@ilen+1,len(filename)-@ilen), upper(right(filename,3))
  from ctl.wrk03 EXCEPT
select filename, md5 ,name, ext
  from ctl.control;

/*
select filename, md5, substring(filename,33,len(filename)-33+1), upper(right(filename,3))
  from ctl.wrk03 EXCEPT
select filename, md5 ,name, ext
  from ctl.control;
*/

UPDATE ctl.wrk02
SET hora = IIF(len(replace(hora,' ',''))=5,concat('0',replace(hora,' ','')),hora);

END
GO