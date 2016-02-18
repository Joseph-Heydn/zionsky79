use TwelveskyWeb
go
if object_id('dbo.uspGetArticleList') is null
	exec ('create procedure dbo.uspGetArticleList as select 1')
--	drop procedure dbo.uspGetArticleList
go
/******************************************************************************
	Name		: dbo.uspGetArticleList
	Description	: �Խù� ��� (�˻� ����)
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArticleList
(	@pMenuNo		int
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pPageSize		tinyint		-- �������� �Խù� ��
,	@pJumpSize		int			-- [1 -> 2 : 1], [10 -> 9 : -1]
,	@pCheckNext		int			-- �������� ������ �ִ��� Ȯ�� ��û [(������ũ�� * ��) + 1]
,	@pLastWriteNo	bigint		-- ���� ������ ������ ��ȣ (�⺻��:9223372036854775807)
--,	@pStartCate		tinyint		-- �з� �˻� ���۹�ȣ (�⺻��:0)
--,	@pLimitCate		tinyint		-- �з� �˻� ��ħ��ȣ (�⺻��:255)
,	@pFilterKey		tinyint		-- 1:UserId, 2:NickName, 3:Subject, 4:Contents, 5:Subject+Contents
,	@pFilterTxt		nvarchar(30)
,	@oBlockCnt		int		output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vTopSize int = (@pPageSize * abs(@pJumpSize))
	declare	@vStartNo int = (@vTopSize - @pPageSize) + 1
		,	@vLimitNo int = (@vTopSize)
	select	@oBlockCnt = 0
		,	@oReturnNo = 1

	-- �˻� ���� ����
	if @pFilterKey > 0 and len(@pFilterTxt) > 1
	begin
		exec dbo.uspGetArticleSearchList
				@pMenuNo		= @pMenuNo
			,	@pPublisher		= @pPublisher
			,	@pJumpSize		= @pJumpSize
			,	@pStartNo		= @vStartNo
			,	@pLimitNo		= @vLimitNo
			,	@pCheckNext		= @pCheckNext
			,	@pLastWriteNo	= @pLastWriteNo
		--	,	@pStartCate		= @pStartCate
		--	,	@pLimitCate		= @pLimitCate
			,	@pFilterKey		= @pFilterKey
			,	@pFilterTxt		= @pFilterTxt
			,	@oBlockCnt		= @oBlockCnt output
			,	@oReturnNo		= @oReturnNo output

		return 0
	end


	-- ���� ���� �Խù��� �ִ��� Ȯ��
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
		--	and	cCate1		between @pStartCate and @pLimitCate
	end

	-- 1 -> 2 .. �������� �̵�
	if sign(@pJumpSize) = 1
	begin
		;with cteArticleInfo as (
			select	top (@vTopSize)
					row_number() over(order by cWriteNo desc) as cRows
				,	cWriteNo
			from	dbo.tArticleInfo
			where	cMenuNo		= @pMenuNo
				and	cPublisher	= @pPublisher
				and	cWriteNo	< @pLastWriteNo
				and	cNotis		is null
				and	cDrop		= 0
			--	and	cCate1		between @pStartCate and @pLimitCate
		)
		select	b.cWriteNo
			,	cSubject
			,	cSummary
		--	,	cAccountId
			,	cWriter
			,	cView		-- ����
			,	cRecep		-- ���� �Ϸ�
			,	cReady		-- �亯 �غ� ��
			,	cReply		-- �亯 �Ϸ�
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
		where	b.cMenuNo	= @pMenuNo
			and	a.cRows		between @vStartNo and @vLimitNo
		order by b.cWriteNo desc
	end
	-- 10 -> 9 .. �������� �̵�
	else
	begin
		;with cteArticleInfo as (
			select	top (@vTopSize)
					row_number() over(order by cWriteNo) as cRows
				,	cWriteNo
			from	dbo.tArticleInfo
			where	cMenuNo		= @pMenuNo
				and	cPublisher	= @pPublisher
				and	cWriteNo	> @pLastWriteNo
				and	cNotis		is null
				and	cDrop		= 0
			--	and	cCate1		between @pStartCate and @pLimitCate
		)
		select	b.cWriteNo
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
		where	b.cMenuNo	= @pMenuNo
			and	a.cRows		between @vStartNo and @vLimitNo
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
exec dbo.uspGetArticleList
 @pMenuNo = 1000001
,@pPublisher = 1
,@pPageSize = 20
,@pJumpSize = 1
,@pCheckNext = 101
,@pLastWriteNo = 9223372036854775807
--,@pStartCate = 1
--,@pLimitCate = 1
,@pFilterKey = 0
,@pFilterTxt = N'status'
,@oBlockCnt = @o1 out
,@oReturnNo = @sp out

print @o1
print @sp
*/
go

grant execute on dbo.uspGetArticleList to [sawebuser]
go

