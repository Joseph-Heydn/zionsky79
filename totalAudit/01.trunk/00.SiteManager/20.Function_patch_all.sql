use SiteManager
go
if object_id('dbo.fnTbl2Bigint') is null
begin
	exec('create function dbo.fnTbl2Bigint (@p1 int) returns @tbl table (a int) as begin insert @tbl select 1 as cSeqNo return end')
/*
	drop function dbo.fnTbl2Bigint
*/
end
go

alter function dbo.fnTbl2Bigint
(	@pString	varchar(max)
,	@pSplit		char(1)
) returns @tblResult table (
	cSeqNo	int		not null
,	cValue	bigint	not null
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
select * from dbo.fnTbl2Bigint(@pString,',')
*/
go

use SiteManager
go
if object_id('dbo.fnTbl2Int') is null
begin
	exec('create function dbo.fnTbl2Int (@p1 int) returns @tbl table (a int) as begin insert @tbl select 1 as cSeqNo return end')
/*
	drop function dbo.fnTbl2Int
*/
end
go

alter function dbo.fnTbl2Int
(	@pString	varchar(max)
,	@pSplit		char(1)
) returns @tblResult table (
	cSeqNo	int		not null
,	cValue	int		not null
) as
begin
	declare @xmlString xml
	set @xmlString = convert(xml,N'<x n="'+ replace(@pString,@pSplit,'"/><x n="') +'"/>')

	insert into @tblResult
		(	cSeqNo
		,	cValue
		)
	select	row_number() over(order by (select 1))
		,	col.value('@n','int')
	from	@xmlString.nodes('/x') as A (col)


	return
end
/*
use SiteManager
declare @pString varchar(max) = '123,654,78,982,4587,21,1,23,57,85,96,7'
select * from dbo.fnTbl2Int(@pString,',')
*/
go

use SiteManager
go
if object_id('dbo.fnTbl2NString') is null
begin
	exec('create function dbo.fnTbl2NString (@p1 int) returns @tbl table (a int) as begin insert @tbl select 1 as cSeqNo return end')
/*
	drop function dbo.fnTbl2NString
*/
end
go

alter function dbo.fnTbl2NString
(	@pString	nvarchar(max)
,	@pSplit		char(1)
) returns @tblResult table (
	cSeqNo	int				not null
,	cValue	nvarchar(20)	not null
) as
begin
	declare @xmlString xml
	set @xmlString = convert(xml,N'<x n="'+ replace(@pString,@pSplit,'"/><x n="') +'"/>')

	insert into @tblResult
		(	cSeqNo
		,	cValue
		)
	select	row_number() over(order by (select 1))
		,	col.value('@n','nvarchar(20)')
	from	@xmlString.nodes('/x') as A (col)


	return
end
/*
use SiteManager
declare @pString varchar(max) = '123,654,78,982,4587,21,1,23,57,85,96,7'
select * from dbo.fnTbl2NString(@pString,',')
*/
go

use SiteManager
go
if object_id('dbo.fnTbl2Smallint') is null
begin
	exec('create function dbo.fnTbl2Smallint (@p1 int) returns @tbl table (a int) as begin insert @tbl select 1 as cSeqNo return end')
/*
	drop function dbo.fnTbl2Smallint
*/
end
go

alter function dbo.fnTbl2Smallint
(	@pString	varchar(max)
,	@pSplit		char(1)
) returns @tblResult table (
	cSeqNo	int			not null
,	cValue	smallint	not null
) as
begin
	declare @xmlString xml
	set @xmlString = convert(xml,N'<x n="'+ replace(@pString,@pSplit,'"/><x n="') +'"/>')

	insert into @tblResult
		(	cSeqNo
		,	cValue
		)
	select	row_number() over(order by (select 1))
		,	col.value('@n','smallint')
	from	@xmlString.nodes('/x') as A (col)


	return
end
/*
use SiteManager
declare @pString varchar(max) = '123,654,78,982,4587,21,1,23,57,85,96,7'
select * from dbo.fnTbl2Smallint(@pString,',')
*/
go

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

use SiteManager
go
if object_id('dbo.fnTbl2Tinyint') is null
begin
	exec('create function dbo.fnTbl2Tinyint (@p1 int) returns @tbl table (a int) as begin insert @tbl select 1 as cSeqNo return end')
/*
	drop function dbo.fnTbl2Tinyint
*/
end
go

alter function dbo.fnTbl2Tinyint
(	@pString	varchar(max)
,	@pSplit		char(1)
) returns @tblResult table (
	cSeqNo	int		not null
,	cValue	tinyint	not null
) as
begin
	declare @xmlString xml
	set @xmlString = convert(xml,N'<x n="'+ replace(@pString,@pSplit,'"/><x n="') +'"/>')

	insert into @tblResult
		(	cSeqNo
		,	cValue
		)
	select	row_number() over(order by (select 1))
		,	col.value('@n','tinyint')
	from	@xmlString.nodes('/x') as A (col)


	return
end
/*
use SiteManager
declare @pString varchar(max) = '123,654,78,982,4587,21,1,23,57,85,96,7'
select * from dbo.fnTbl2Tinyint(@pString,',')
*/
go

