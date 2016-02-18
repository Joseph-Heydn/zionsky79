use TwelveskyWeb
go
if object_id('dbo.uspGetArticleAroundSearchInfo') is null
	exec ('create procedure dbo.uspGetArticleAroundSearchInfo as select 1')
--	drop procedure dbo.uspGetArticleAroundSearchInfo
go
/******************************************************************************
	Name		: dbo.uspGetArticleAroundSearchInfo
	Description	: 현재 게시물 앞/뒤 게시글 번호 (검색어가 있는 경우)
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArticleAroundSearchInfo
(	@pMenuNo		int
,	@pWriteNo		bigint		-- 현재 페이지 마지막 번호 (기본값:9223372036854775807)
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
--,	@pStartCate		tinyint		-- 분류 검색 시작번호 (기본값:0)
--,	@pLimitCate		tinyint		-- 분류 검색 마침번호 (기본값:255)
,	@pLimitDate		datetime	-- 기본값 1개월
,	@pFilterKey		tinyint		-- 1:UserId, 2:NickName, 3:Subject, 4:Contents, 5:Subject+Contents
,	@pAccountId		varchar(20)
,	@pNickName		nvarchar(20)
,	@pFilterTxt		nvarchar(30)
,	@pNotice		tinyint
,	@oPrevWrite		bigint	output
,	@oNextWrite		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oPrevWrite	= 0
		,	@oNextWrite	= 0
		,	@oReturnNo	= 1

	-- cAccountId
	if @pFilterKey = 1
	begin
		-- 이전 글번호 (작은번호)
		select	top (1)
				@oPrevWrite	= cWriteNo
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cWriteNo	> @pWriteNo
			and	cNotis		is null
			and	cDrop		= 0
			and	cAccountId	= @pAccountId
		--	and	cCategory	between @pStartCate and @pLimitCate
		order by cWriteNo

		-- 다음 글번호 (큰번호)
		select	top (1)
				@oNextWrite	= cWriteNo
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cWriteNo	< @pWriteNo
			and	cNotis		is null
			and	cDrop		= 0
			and	cAccountId	= @pAccountId
		--	and	cCategory	between @pStartCate and @pLimitCate
		order by cWriteNo desc
	end
	-- cWriter
	else if @pFilterKey = 2
	begin
		select	top (1)
				@oPrevWrite	= cWriteNo
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cWriteNo	> @pWriteNo
			and	cNotis		is null
			and	cDrop		= 0
			and	cWriter		= @pNickName
		--	and	cCategory	between @pStartCate and @pLimitCate
		order by cWriteNo

		select	top (1)
				@oNextWrite	= cWriteNo
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cWriteNo	< @pWriteNo
			and	cNotis		is null
			and	cDrop		= 0
			and	cWriter		= @pNickName
		--	and	cCategory	between @pStartCate and @pLimitCate
		order by cWriteNo desc
	end
	-- cSubject
	else if @pFilterKey = 3
	begin
		select	top (1)
				@oPrevWrite	= cWriteNo
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cWriteNo	> @pWriteNo
			and	cNotis		is null
			and	cDrop		= 0
			and	cSubject	like '%'+ @pFilterTxt +'%'
		--	and	cCategory	between @pStartCate and @pLimitCate
		order by cWriteNo

		select	top (1)
				@oNextWrite	= cWriteNo
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cWriteNo	< @pWriteNo
			and	cNotis		is null
			and	cDrop		= 0
			and	cSubject	like '%'+ @pFilterTxt +'%'
		--	and	cCategory	between @pStartCate and @pLimitCate
		order by cWriteNo desc
	end
	-- cContents
	else if @pFilterKey = 4
	begin
		select	top (1)
				@oPrevWrite	= cWriteNo
		from	dbo.tContentsInfo
		where	cMenuNo		= @pMenuNo
			and	cLangNo		= @pPublisher
			and	cWriteNo	> @pWriteNo
			and	cContents	like '%'+ @pFilterTxt +'%'
		--	and	cCategory	between @pStartCate and @pLimitCate
		order by cWriteNo

		select	top (1)
				@oNextWrite	= cWriteNo
		from	dbo.tContentsInfo
		where	cMenuNo		= @pMenuNo
			and	cLangNo		= @pPublisher
			and	cWriteNo	< @pWriteNo
			and	cContents	like '%'+ @pFilterTxt +'%'
		--	and	cCategory	between @pStartCate and @pLimitCate
		order by cWriteNo desc
	end
	-- cNotice
	else if @pFilterKey = 6
	begin
		select	top (1)
				@oPrevWrite	= cWriteNo
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cNotis		< @pNotice
			and cNotis		> 0
		order by cNotis

		select	top (1)
				@oNextWrite	= cWriteNo
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cPublisher	= @pPublisher
			and	cNotis		> @pNotice
			and cNotis		> 0
		order by cNotis
	end


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
exec dbo.uspGetArticleAroundSearchInfo
 @pMenuNo = 1000016
,@pWriteNo = 19999
,@pPublisher = 1
--,@pStartCate = 0
--,@pLimitCate = 255
,@pLimitDate = '2015-01-01'
,@pFilterKey = 6
,@pAccountId = N''
,@pNickName = N''
,@pFilterTxt = N''
,@pNotice = 2
,@oPrevWrite = @o1 out
,@oNextWrite = @o2 out
,@oReturnNo = @sp out

print @o1
print @o2
print @sp
*/
go

