use SiteManager
go
if object_id('dbo.fnTbl2String') is null
begin
	exec('create function dbo.fnTbl2String (@p1 int) returns @tbl table (a int) as begin insert @tbl select 1 as cSeqNo return end')
/*
	drop function dbo.fnTbl2String
*/
end
go

alter function dbo.fnTbl2String
(	@pString	varchar(max)
,	@pSplit		char(1)
) returns @tblResult table (
	cSeqNo	int			not null
,	cValue	varchar(20)	not null
) as
begin
	declare @xmlString xml
	set @xmlString = convert(xml,N'<x n="'+ replace(@pString,@pSplit,'"/><x n="') +'"/>')

	insert into @tblResult
		(	cSeqNo
		,	cValue
		)
	select	row_number() over(order by (select 1))
		,	col.value('@n','varchar(20)')
	from	@xmlString.nodes('/x') as A (col)


	return
end
/*
use SiteManager
declare @pString varchar(max) = '123,654,78,982,4587,21,1,23,57,85,96,7'
select * from dbo.fnTbl2String(@pString,',')
*/
go

