use TwelveskyWeb
go
if object_id('dbo.uspGetMainList') is null
	exec ('create procedure dbo.uspGetMainList as select 1')
--	drop procedure dbo.uspGetMainList
go
/******************************************************************************
	Name		: dbo.uspGetMainList
	Description	: 메인 노출 게시판, 게시물 목록
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetMainList
(	@pGameNo		int
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vTopCnt_01 int = 10
		,	@vTopCnt_02 int = 10
		,	@vTopCnt_03 int = 10
		,	@vTopCnt_04 int = 10
		,	@vTopCnt_05 int = 10
	set @oReturnNo = 1

	select	@vTopCnt_01	= case cOrderMain when 1 then cTopCnt else @vTopCnt_01 end
		,	@vTopCnt_02	= case cOrderMain when 2 then cTopCnt else @vTopCnt_02 end
		,	@vTopCnt_03	= case cOrderMain when 3 then cTopCnt else @vTopCnt_03 end
		,	@vTopCnt_04	= case cOrderMain when 4 then cTopCnt else @vTopCnt_04 end
		,	@vTopCnt_05	= case cOrderMain when 5 then cTopCnt else @vTopCnt_05 end
	from	dbo.tBoardMaster
	where	cGameNo		= @pGameNo
		and	cIsUsed		= 1
		and	cIsMain		= 1
	order by cOrderMain


	-- 메인 이미지
	select	top (@vTopCnt_01)
			cMenuNo
		,	cWriteNo
		,	cSubject
		,	cFolder
		,	cImage
		,	cExts
	from	dbo.tArticleInfo
	where	cMenuNo		= 1000001
		and	cPublisher	= @pPublisher
		and	cDrop		= 0
		and	cNotis		> 0
	order by cNotis
	option (optimize for (@vTopCnt_01 = 5))


	-- 광고 목록
	select	top (@vTopCnt_04)
			cMenuNo
		,	cWriteNo
		,	cSubject
		,	cWriter
		,	cFolder
		,	cImage
		,	cExts
		,	cSummary
		,	cCreateTime
	from	dbo.tArticleInfo
	where	cMenuNo		= 1000004
		and	cPublisher	= @pPublisher
		and	cDrop		= 0
		and	cNotis		is null
	order by cWriteNo desc
	option (optimize for (@vTopCnt_04 = 5))


	-- 동영상
	select	top (@vTopCnt_02)
			cSubject
		,	cLink
	from	dbo.tArticleInfo
	where	cMenuNo		= 1000002
		and	cPublisher	= @pPublisher
		and	cView		= 1
		and	cDrop		= 0
		and	cNotis		is null
	order by cWriteNo desc
	option (optimize for (@vTopCnt_02 = 3))


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare @sp int
exec dbo.uspGetMainList
 @pGameNo = 2016001
,@pPublisher = 2
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.uspGetMainList to [sawebuser]
go

