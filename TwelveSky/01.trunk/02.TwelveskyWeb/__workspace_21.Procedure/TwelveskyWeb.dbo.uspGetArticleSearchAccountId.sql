use TwelveskyWeb
go
if object_id('dbo.uspGetArticleSearchAccountId') is null
	exec ('create procedure dbo.uspGetArticleSearchAccountId as select 1')
--	drop procedure dbo.uspGetArticleSearchAccountId
go
/******************************************************************************
	Name		: dbo.uspGetArticleSearchAccountId
	Description	: 게시물 검색 (유저아이디)
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArticleSearchAccountId
(	@pMenuNo		int
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pJumpSize		int			-- [1 -> 2 : 1], [10 -> 9 : -1]
,	@pStartNo		int			-- 페이징 범위
,	@pLimitNo		int			-- 페이징 범위
,	@pCheckNext		int			-- 다음블럭에 데이터 있는지 확인 요청 ((페이지크기 * 블럭) + 1)
,	@pLastWriteNo	bigint		-- 현재 페이지 마지막 번호
--,	@pStartCate		tinyint		-- 분류 검색 시작번호 (기본값:0)
--,	@pLimitCate		tinyint		-- 분류 검색 마침번호 (기본값:255)
,	@pFilterTxt		varchar(20)
,	@oBlockCnt		int		output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oBlockCnt = 0
		,	@oReturnNo = 1

	-- 1 -> 2 .. 방향으로 이동
	if sign(@pJumpSize) = 1
	begin
		-- 다음 블럭에 게시물이 있는지 확인
		if @pCheckNext > 0
		begin
			select	top (@pCheckNext)
					@oBlockCnt	+= 1
			from	dbo.tArticleInfo
			where	cMenuNo		= @pMenuNo
				and	cPublisher	= @pPublisher
				and	cWriteNo	< @pLastWriteNo
				and	cNotis		is null
				and	cDrop		= 0
				and	cAccountId	= @pFilterTxt
			--	and	cCategory	between @pStartCate and @pLimitCate
		end


		;with cteArticleInfo as (
			select	top (@pLimitNo)
					row_number() over(order by cWriteNo desc) as cRows
				,	cWriteNo
			from	dbo.tArticleInfo
			where	cMenuNo		= @pMenuNo
				and	cPublisher	= @pPublisher
				and	cWriteNo	< @pLastWriteNo
				and	cNotis		is null
				and	cDrop		= 0
				and	cAccountId	= @pFilterTxt
			--	and	cCategory	between @pStartCate and @pLimitCate
		)
		select	b.cWriteNo
		--	,	cCate1
		--	,	cCate2
			,	cSubject
			,	cSummary
		--	,	cAccountId
			,	cWriter
			,	cView
			,	cRecep
			,	cReady
			,	cReply
			,	cViewCnt
			,	cReplyCnt
			,	cRecmdCnt
			,	cFolder
			,	cImage
			,	cExts
			,	cLink
			,	cReplyTime
			,	cCreateTime
		from	cteArticleInfo as a
				inner join
				dbo.tArticleInfo as b
			on	b.cWriteNo	= a.cWriteNo
		where	a.cRows		between @pStartNo and @pLimitNo
			and	b.cMenuNo	= @pMenuNo
		order by b.cWriteNo desc
	end
	-- 10 -> 9 .. 방향으로 이동
	else
	begin
		;with cteArticleInfo as (
			select	top (@pLimitNo)
					row_number() over(order by cWriteNo) as cRows
				,	cWriteNo
			from	dbo.tArticleInfo
			where	cMenuNo		= @pMenuNo
				and	cPublisher	= @pPublisher
				and	cWriteNo	> @pLastWriteNo
				and	cNotis		is null
				and	cDrop		= 0
				and	cAccountId	= @pFilterTxt
			--	and	cCategory	between @pStartCate and @pLimitCate
		)
		select	b.cWriteNo
		--	,	cCate1
		--	,	cCate2
			,	cSubject
			,	cSummary
		--	,	cAccountId
			,	cWriter
			,	cView
			,	cRecep
			,	cReady
			,	cReply
			,	cViewCnt
			,	cReplyCnt
			,	cRecmdCnt
			,	cFolder
			,	cImage
			,	cExts
			,	cLink
			,	cReplyTime
			,	cCreateTime
		from	cteArticleInfo as a
				inner join
				dbo.tArticleInfo as b
			on	b.cWriteNo	= a.cWriteNo
		where	a.cRows		between @pStartNo and @pLimitNo
			and	b.cMenuNo	= @pMenuNo
		order by b.cWriteNo desc
		option (optimize for (@pLastWriteNo = 1))
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
exec dbo.uspGetArticleSearchAccountId
 @pMenuNo = 10001
,@pPublisher = 1
,@pJumpSize = 1
,@pStartNo = 1
,@pLimitNo = 20
,@pCheckNext = 101
,@pLastWriteNo = 999999999999999999
--,@pStartCate = 1
--,@pLimitCate = 255
,@pFilterTxt = N'rsid'
,@oBlockCnt = @o1 out
,@oReturnNo = @sp out

print @o1
print @sp
*/
go

