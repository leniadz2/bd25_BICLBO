SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [ctl].[ctl02_post]
AS
BEGIN

insert into ctl.control
select w4.name,
       w4.md5,
       upper(extension) as ext,
       w4.filename,
       (select w1.date from ctl.wrk01 as w1) as date,
       (select w2.hora from ctl.wrk02 as w2) as hora
  from ctl.wrk04 as w4;

END
GO