use TwelveskyWeb
go
if object_id('dbo.uspFindObject') is null
	exec ('create procedure dbo.uspFindObject as select 1')
--	drop procedure dbo.uspFindObject
go
/******************************************************************************
	Name		: dbo.uspFindObject
	Description	: 프로시저에서 개체 검색
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-05	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspFindObject
(	@pObjName	sysname

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	object_name(id) as cObjName
		,	count(*) as cRowCnt
	from	syscomments
	where	[text] like '%'+ @pObjName +'%'
	group by id
	order by cObjName


	set nocount off
end
/*
set statistics io on
use TwelveskyWeb
exec @sp = dbo.uspFindObject
@pObjName = ''
*/
go

