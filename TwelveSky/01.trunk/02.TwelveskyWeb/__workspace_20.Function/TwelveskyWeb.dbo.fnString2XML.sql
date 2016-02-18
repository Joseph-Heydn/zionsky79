use TwelveskyWeb
go
if object_id('dbo.fnString2XML') is null
begin
	exec ('create function dbo.fnString2XML (@p1 varchar(10)) returns xml AS begin RETURN ('''') end')
/*
	drop function dbo.fnString2XML
*/
end
go
alter function dbo.fnString2XML
(	@pString	nvarchar(max)
,	@pSplit		char(1)

) returns xml as
begin
	return (
		convert(xml,'<x n="'+ replace(stuff(@pString,1,1,''),@pSplit,'"/><x n="') +'"/>')
	)
end
go
/*
use TwelveskyWeb
set statistics io on
declare
 @p1 varchar(max) = ',1,2,3,4,5,6,7,8,9,0'
,@p2 char(1) = ','
select dbo.fnString2XML(@p1,@p2)
*/
GO

