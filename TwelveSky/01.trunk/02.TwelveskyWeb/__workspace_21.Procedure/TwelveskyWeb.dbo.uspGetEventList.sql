use TwelveskyWeb
go
if object_id('dbo.uspGetEventList') is null
	exec ('create procedure dbo.uspGetEventList as select 1')
--	drop procedure dbo.uspGetEventList
go
/******************************************************************************
	Name		: dbo.uspGetEventList
	Description	: 이벤트 목록 (인게임 포함)
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetEventList
(	@pMenuNo		int
,	@pPublisher		tinyint	-- 1:my, 2:ph, 3:th, 4:vn
,	@pTopSize		tinyint	-- 페이지당 게시물 수
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	top (@pTopSize)
			cWriteNo
		,	cLink
		,	cReady
		,	cFolder
		,	cImage
		,	cExts
	from	dbo.tArticleInfo
	where	cMenuNo		= @pMenuNo
		and	cPublisher	= @pPublisher
		and	cEvent		> 0
		and	cDrop		= 0
	order by cEvent


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare @sp int
exec dbo.uspGetEventList
 @pMenuNo = 1000016
,@pPublisher = 1
,@pTopSize = 4
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.uspGetEventList to [sawebuser]
go

