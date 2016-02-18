use TwelveskyWeb
go
if object_id('dbo.uspGetCategoryList') is null
	exec ('create procedure dbo.uspGetCategoryList as select 1')
--	drop procedure dbo.uspGetCategoryList
go
/******************************************************************************
	Name		: dbo.uspGetCategoryList
	Description	: 게시판 글 카테고리
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCategoryList
(	@pMenuNo	int
,	@pLangNo	tinyint
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	cStep
		,	cCategory
		,	cRefs
		,	cCateName
	--	,	cWriteCnt
		,	cOrderBy
	from	dbo.tCategoryMenu
	where	cMenuNo	= @pMenuNo
		and	cLangNo	= @pLangNo
		and	cUsing	= 1
		and	cView	= 1


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare @sp int
exec dbo.uspGetCategoryList
 @pMenuNo = 1000020
,@pLangNo = 1
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.uspGetCategoryList to [sawebuser]
go

