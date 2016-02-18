use TwelveskyWeb
go
if object_id('dbo.uspGetFieldMenuList') is null
	exec ('create procedure dbo.uspGetFieldMenuList as select 1')
--	drop procedure dbo.uspGetFieldMenuList
go
/******************************************************************************
	Name		: dbo.uspGetFieldMenuList
	Description	: 메인 노출 게시판, 게시물 목록
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetFieldMenuList
(	@pGameNo	int
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	cType
		,	cMenuNo
		,	cFolder
		,	cMenuName
		,	cIsWrite
		,	cIsReply
		,	cIsRepot
		,	cIsView
		,	cIsAuth
		,	cIsPubs
	from	dbo.tBoardMaster
	where	cGameNo	= @pGameNo
		and	cIsUsed = 1
	--	and	cIsView = 1


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare @sp int
exec dbo.uspGetFieldMenuList
 @pGameNo = 2016001
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.uspGetFieldMenuList to [sawebuser]
go

