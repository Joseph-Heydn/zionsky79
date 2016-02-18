use TwelveskyWeb
go
if object_id('dbo.fnTbl2Bigint') is null
begin
	exec ('create function dbo.fnTbl2Bigint (@p1 int) returns table as return select 1 as cSeqNo')
/*
	drop function dbo.fnTbl2Bigint
*/
end
go
alter function dbo.fnTbl2Bigint
(	@pString	xml

) returns table
as
return (
	select	row_number() over(order by (select 1)) as cRows
		,	col.value('@n','bigint') as cValue
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

select * from dbo.fnTbl2Bigint(@p1)
*/
go

