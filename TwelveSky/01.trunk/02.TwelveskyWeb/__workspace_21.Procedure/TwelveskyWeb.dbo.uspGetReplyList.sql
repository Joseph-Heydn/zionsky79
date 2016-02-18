use TwelveskyWeb
go
if object_id('dbo.uspGetReplyList') is null
	exec ('create procedure dbo.uspGetReplyList as select 1')
--	drop procedure dbo.uspGetReplyList
go
/******************************************************************************
	Name		: dbo.uspGetReplyList
	Description	: 게시물 댓글 목록
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetReplyList
(	@pWriteNo		bigint
,	@pPageSize		tinyint
,	@pJumpSize		int
,	@pCheckNext		int
,	@pLastCommtNo	bigint
,	@oBlockCnt		int		output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vTopSize int = (@pPageSize*abs(@pJumpSize))
	declare	@vStartNo int = (@vTopSize - @pPageSize) + 1
		,	@vLimitNo int = (@vTopSize)
	select	@oBlockCnt	= 0
		,	@oReturnNo	= 1

	-- 다음 블럭에 게시물이 있는지 확인
	if @pCheckNext > 0
	begin
		select	top (@pCheckNext)
				@oBlockCnt	+= 1
		from	dbo.tCommentInfo
		where	cWriteNo	= @pWriteNo
			and	cCommtNo	< @pLastCommtNo
			and	cDrop		= 0
	end

	-- 1 -> 2 .. 방향으로 이동
	if sign(@pJumpSize) = 1
	begin
		;with cteCommentInfo as (
			select	top (@vTopSize)
					row_number() over(order by cCommtNo desc) as cRows
				,	cCommtNo
			from	dbo.tCommentInfo
			where	cWriteNo	= @pWriteNo
				and	cCommtNo	< @pLastCommtNo
				and	cDrop		= 0
		)
		select	b.cCommtNo
			,	cAccountNo
			,	cWriter
			,	cComments
			,	cHostIp
			,	cView
			,	isnull(cRecmdCnt,0) as cRecmdCnt
			,	isnull(cAgnstCnt,0) as cAgnstCnt
			,	isnull(cRepotCnt,0) as cRepotCnt
			,	cCreateTime
		from	cteCommentInfo as a
				inner join
				dbo.tCommentInfo as b
			on	b.cCommtNo	= a.cCommtNo
		where	b.cWriteNo	= @pWriteNo
			and	a.cRows		between @vStartNo and @vLimitNo
		order by b.cCommtNo desc
	end
	-- 10 -> 9 .. 방향으로 이동
	else
	begin
		;with cteCommentInfo as (
			select	top (@vTopSize)
					row_number() over(order by cCommtNo) as cRows
				,	cCommtNo
			from	dbo.tCommentInfo
			where	cWriteNo	= @pWriteNo
				and	cCommtNo	> @pLastCommtNo
				and	cDrop		= 0
		)
		select	b.cCommtNo
			,	cAccountNo
			,	cWriter
			,	cComments
			,	cHostIp
			,	cView
			,	isnull(cRecmdCnt,0) as cRecmdCnt
			,	isnull(cAgnstCnt,0) as cAgnstCnt
			,	isnull(cRepotCnt,0) as cRepotCnt
			,	cCreateTime
		from	cteCommentInfo as a
				inner join
				dbo.tCommentInfo as b
			on	b.cCommtNo	= a.cCommtNo
		where	b.cWriteNo	= @pWriteNo
			and	a.cRows		between @vStartNo and @vLimitNo
		order by b.cCommtNo desc
		option (optimize for (@pLastCommtNo = 1))
	end


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare
 @o1 int
,@sp int
exec dbo.uspGetReplyList
 @pWriteNo = 17588
,@pPageSize = 20
,@pJumpSize = 1
,@pCheckNext = 1001
,@pLastCommtNo = 9223372036854775807
,@oBlockCnt = @o1 out
,@oReturnNo = @sp out

print @o1
print @sp
*/
go

grant execute on dbo.uspGetReplyList to [sawebuser]
go

