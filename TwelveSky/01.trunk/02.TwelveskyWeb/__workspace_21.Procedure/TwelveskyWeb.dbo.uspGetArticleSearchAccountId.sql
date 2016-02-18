use TwelveskyWeb
go
if object_id('dbo.uspGetArticleSearchAccountId') is null
	exec ('create procedure dbo.uspGetArticleSearchAccountId as select 1')
--	drop procedure dbo.uspGetArticleSearchAccountId
go
/******************************************************************************
	Name		: dbo.uspGetArticleSearchAccountId
	Description	: �Խù� �˻� (�������̵�)
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
,	@pStartNo		int			-- ����¡ ����
,	@pLimitNo		int			-- ����¡ ����
,	@pCheckNext		int			-- �������� ������ �ִ��� Ȯ�� ��û ((������ũ�� * ��) + 1)
,	@pLastWriteNo	bigint		-- ���� ������ ������ ��ȣ
--,	@pStartCate		tinyint		-- �з� �˻� ���۹�ȣ (�⺻��:0)
--,	@pLimitCate		tinyint		-- �з� �˻� ��ħ��ȣ (�⺻��:255)
,	@pFilterTxt		varchar(20)
,	@oBlockCnt		int		output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oBlockCnt = 0
		,	@oReturnNo = 1

	-- 1 -> 2 .. �������� �̵�
	if sign(@pJumpSize) = 1
	begin
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
	-- 10 -> 9 .. �������� �̵�
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

