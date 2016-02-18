use TwelveskyWeb
go
if object_id('dbo.uspGetArticleSearchList') is null
	exec ('create procedure dbo.uspGetArticleSearchList as select 1')
--	drop procedure dbo.uspGetArticleSearchList
go
/******************************************************************************
	Name		: dbo.uspGetArticleSearchList
	Description	: �Խù� �˻� ����
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArticleSearchList
(	@pMenuNo		int
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pJumpSize		int			-- [1 -> 2 : 1], [10 -> 9 : -1]
,	@pStartNo		int			-- ����¡ ����
,	@pLimitNo		int			-- ����¡ ����
,	@pCheckNext		int			-- �������� ������ �ִ��� Ȯ�� ��û ((������ũ�� * ��) + 1)
,	@pLastWriteNo	bigint		-- ���� ������ ������ ��ȣ
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

	select	@oBlockCnt = 0
		,	@oReturnNo = 1

	-- UserId
	if @pFilterKey = 1
	begin
		exec dbo.uspGetArticleSearchAccountId
				@pMenuNo		= @pMenuNo
			,	@pPublisher		= @pPublisher
			,	@pJumpSize		= @pJumpSize
			,	@pStartNo		= @pStartNo
			,	@pLimitNo		= @pLimitNo
			,	@pCheckNext		= @pCheckNext
			,	@pLastWriteNo	= @pLastWriteNo
		--	,	@pStartCate		= @pStartCate
		--	,	@pLimitCate		= @pLimitCate
			,	@pFilterTxt		= @pFilterTxt
			,	@oBlockCnt		= @oBlockCnt output
			,	@oReturnNo		= @oReturnNo output
	end
	-- NickName
	else if @pFilterKey = 2
	begin
		exec dbo.uspGetArticleSearchNickName
				@pMenuNo		= @pMenuNo
			,	@pPublisher		= @pPublisher
			,	@pJumpSize		= @pJumpSize
			,	@pStartNo		= @pStartNo
			,	@pLimitNo		= @pLimitNo
			,	@pCheckNext		= @pCheckNext
			,	@pLastWriteNo	= @pLastWriteNo
		--	,	@pStartCate		= @pStartCate
		--	,	@pLimitCate		= @pLimitCate
			,	@pFilterTxt		= @pFilterTxt
			,	@oBlockCnt		= @oBlockCnt output
			,	@oReturnNo		= @oReturnNo output
	end
	-- Subject
	else if @pFilterKey = 3
	begin
		exec dbo.uspGetArticleSearchSubject
				@pMenuNo		= @pMenuNo
			,	@pPublisher		= @pPublisher
			,	@pJumpSize		= @pJumpSize
			,	@pStartNo		= @pStartNo
			,	@pLimitNo		= @pLimitNo
			,	@pCheckNext		= @pCheckNext
			,	@pLastWriteNo	= @pLastWriteNo
		--	,	@pStartCate		= @pStartCate
		--	,	@pLimitCate		= @pLimitCate
			,	@pFilterTxt		= @pFilterTxt
			,	@oBlockCnt		= @oBlockCnt output
			,	@oReturnNo		= @oReturnNo output
	end
	-- Contents
	else if @pFilterKey = 4
	begin
		exec dbo.uspGetArticleSearchContents
				@pMenuNo		= @pMenuNo
			,	@pPublisher		= @pPublisher
			,	@pJumpSize		= @pJumpSize
			,	@pStartNo		= @pStartNo
			,	@pLimitNo		= @pLimitNo
			,	@pCheckNext		= @pCheckNext
			,	@pLastWriteNo	= @pLastWriteNo
		--	,	@pStartCate		= @pStartCate
		--	,	@pLimitCate		= @pLimitCate
			,	@pFilterTxt		= @pFilterTxt
			,	@oBlockCnt		= @oBlockCnt output
			,	@oReturnNo		= @oReturnNo output
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
exec dbo.uspGetArticleSearchList
 @pMenuNo = 10001
,@pPublisher = 1
,@pJumpSize = 1
,@pStartNo = 1
,@pLimitNo = 20
,@pCheckNext = 101
,@pLastWriteNo = 999999999999999999
--,@pStartCate = 1
--,@pLimitCate = 255
,@pFilterKey = 1
,@pFilterTxt = N'rsid'
,@oBlockCnt = @o1 out
,@oReturnNo = @sp out

print @o1
print @sp
*/
go

grant execute on dbo.uspGetArticleSearchList to [sawebuser]
go

