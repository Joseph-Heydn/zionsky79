use TwelveskyWeb
go
if object_id('dbo.fnTbl2Tinyint') is null
begin
	exec ('create function dbo.fnTbl2Tinyint (@p1 int) returns table as return select 1 as cSeqNo')
/*
	drop function dbo.fnTbl2Tinyint
*/
end
go
alter function dbo.fnTbl2Tinyint
(	@pString	xml

) returns table
as
return (
	select	row_number() over(order by (select 1)) as cRows
		,	col.value('@n','tinyint') as cValue
	from	@pString.nodes('/x') as a (col)
)
go
/*
use TwelveskyWeb
set statistics io on
declare
 @pString varchar(max) = ',1,2,3,4,5,6,7,8,9,0'
,@pSplit char(1) = ','
,@p1 xml
set @p1 = convert(xml,'<x n="'+ replace(stuff(@pString,1,1,''),@pSplit,'"/><x n="') +'"/>')

select * from dbo.fnTbl2Tinyint(@p1)
*/
go

