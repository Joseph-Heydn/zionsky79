use TwelveskyWeb
go
if object_id('dbo.uspGetArticleAroundInfo') is null
	exec ('create procedure dbo.uspGetArticleAroundInfo as select 1')
--	drop procedure dbo.uspGetArticleAroundInfo
go
/******************************************************************************
	Name		: dbo.uspGetArticleAroundInfo
	Description	: 현재글의 앞뒤 게시글 번호 찾기
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArticleAroundInfo
(	@pMenuNo		int
,	@pWriteNo		bigint		-- 현재 페이지 마지막 번호 (기본값:9223372036854775807)
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
--,	@pStartCate		tinyint		-- 분류 검색 시작번호 (기본값:0)
--,	@pLimitCate		tinyint		-- 분류 검색 마침번호 (기본값:255)
,	@pLimitDate		datetime	-- 기본값 1개월
,	@pFilterKey		tinyint		-- 1:UserId, 2:NickName, 3:Subject, 4:Contents, 5:Subject+Contents, 6:Notice
,	@pFilterTxt		nvarchar(30)
,	@oPrevWrite		bigint	output
,	@oNextWrite		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vNotice tinyint
	select	@oPrevWrite	= 0
		,	@oNextWrite	= 0
		,	@oReturnNo	= 1

	if @pMenuNo = 0 or @pWriteNo = 0
	begin
		set @oReturnNo = -1
		return -1
	end

	if isnumeric(@pFilterTxt) = 1
		set @vNotice = @pFilterTxt


	-- 검색 조건 있음
	if @pFilterKey > 0 and len(@pFilterTxt) > 1
	begin
		exec dbo.uspGetArticleAroundSearchInfo
				@pMenuNo		= @pMenuNo
			,	@pWriteNo		= @pWriteNo
			,	@pPublisher		= @pPublisher
		--	,	@pStartCate		= @pStartCate
		--	,	@pLimitCate		= @pLimitCate
			,	@pLimitDate		= @pLimitDate
			,	@pFilterKey		= @pFilterKey
			,	@pAccountId		= @pFilterTxt
			,	@pNickName		= @pFilterTxt
			,	@pFilterTxt		= @pFilterTxt
			,	@pNotice		= @vNotice
			,	@oPrevWrite		= @oPrevWrite	output
			,	@oNextWrite		= @oNextWrite	output
			,	@oReturnNo		= @oReturnNo	output

		return 0
	end


	-- 이전 글번호 (현재 글번호 보다 작은번호)
	select	top (1)
			@oPrevWrite	= cWriteNo
	from	dbo.tArticleInfo
	where	cMenuNo		= @pMenuNo
		and	cPublisher	= @pPublisher
		and	cWriteNo	> @pWriteNo
		and	cNotis		is null
		and	cDrop		= 0
	--	and	cCategory	between @pStartCate and @pLimitCate
	order by cWriteNo


	-- 다음 글번호 (현재 글번호 보다 큰번호)
	select	top (1)
			@oNextWrite	= cWriteNo
	from	dbo.tArticleInfo
	where	cMenuNo		= @pMenuNo
		and	cPublisher	= @pPublisher
		and	cWriteNo	< @pWriteNo
		and	cNotis		is null
		and	cDrop		= 0
	--	and	cCategory	between @pStartCate and @pLimitCate
	order by cWriteNo desc


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare
 @o1 int
,@o2 int
,@sp int
exec dbo.uspGetArticleAroundInfo
 @pMenuNo = 1000001
,@pWriteNo = 41
,@pPublisher = 1
--,@pStartCate = 1
--,@pLimitCate = 1
,@pLimitDate = '2015-01-01'
,@pFilterKey = 0
,@pFilterTxt = N'status'
,@oPrevWrite = @o1 out
,@oNextWrite = @o2 out
,@oReturnNo = @sp out

print @o1
print @o2
print @sp
*/
go

