use TwelveskyWeb
go
if object_id('dbo.uspGetBest5List') is null
	exec ('create procedure dbo.uspGetBest5List as select 1')
--	drop procedure dbo.uspGetBest5List
go
/******************************************************************************
	Name		: dbo.uspGetBest5List
	Description	: 인기 top 5 목록
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2016-02-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetBest5List
(	@pMenuNo		int
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	;with cteArticleInfo as (
		select	top (5)
				cWriteNo
			,	cRecmdCnt
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cRecmdCnt	> 1
			and	cNotis		= 0
			and	cDrop		= 0
		order by cRecmdCnt desc
	)
	select	b.cWriteNo
	--	,	cCate1
	--	,	cCate2
		,	cSubject
		,	cSummary
		,	cAccountId
		,	cWriter
		,	cView		-- 노출
		,	cReady		-- 답변 준비 중
		,	cReply		-- 답변 완료
		,	cViewCnt
		,	cReplyCnt
		,	b.cRecmdCnt
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
	order by a.cRecmdCnt desc


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare @sp int
exec dbo.uspGetBest5List
 @pMenuNo = 1000007
,@pPublisher = 1
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.uspGetBest5List to [sawebuser]
go

