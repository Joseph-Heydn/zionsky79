use TwelveskyWeb
go
if object_id('dbo.uspGetNoticeList') is null
	exec ('create procedure dbo.uspGetNoticeList as select 1')
--	drop procedure dbo.uspGetNoticeList
go
/******************************************************************************
	Name		: dbo.uspGetNoticeList
	Description	: 공지사항 목록
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetNoticeList
(	@pMenuNo		int
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	;with cteArticleInfo as (
		select	cWriteNo
			,	cNotis
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cNotis		> 0
			and	cDrop		= 0
	)
	select	b.cWriteNo
	--	,	cCategory
		,	cSubject
		,	cSummary
		,	cAccountId
		,	cWriter
		,	cView		-- 노출
		,	cReady		-- 답변 준비 중
		,	cReply		-- 답변 완료
		,	cViewCnt
		,	cReplyCnt
		,	cRecmdCnt
		,	cFolder
		,	cImage
		,	cExts
		,	cReplyTime
		,	cCreateTime
	from	cteArticleInfo as a
			inner join
			dbo.tArticleInfo as b
		on	b.cWriteNo	= a.cWriteNo
	where	b.cMenuNo	= @pMenuNo
	order by a.cNotis


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare @sp int
exec dbo.uspGetNoticeList
 @pMenuNo = 1000007
,@pPublisher = 1
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.uspGetNoticeList to [sawebuser]
go

