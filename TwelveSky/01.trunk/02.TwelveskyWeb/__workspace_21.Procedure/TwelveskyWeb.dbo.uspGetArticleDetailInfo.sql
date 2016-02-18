use TwelveskyWeb
go
if object_id('dbo.uspGetArticleDetailInfo') is null
	exec ('create procedure dbo.uspGetArticleDetailInfo as select 1')
--	drop procedure dbo.uspGetArticleDetailInfo
go
/******************************************************************************
	Name		: dbo.uspGetArticleDetailInfo
	Description	: 게시물 상세 보기
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArticleDetailInfo
(	@pMenuNo		int
,	@pWriteNo		bigint
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pLanguage		tinyint		-- 1:my, 2:ph, 3:vn
--,	@pLimitCate		tinyint
,	@pLimitDate		datetime
,	@pFilterKey		tinyint
,	@pFilterTxt		nvarchar(30)
,	@pIsQnA			bit
,	@pIsRead		bit
,	@pIsFile		bit
,	@pIsAround		bit
,	@oAccountNo		bigint			output
,	@oWriter		nvarchar(16)	output
,	@oEmail			varchar(50)		output
,	@oHostIp		varchar(15)		output
,	@oViewCnt		int				output
,	@oRecmdCnt		int				output
,	@oAgnstCnt		int				output
,	@oCate1			tinyint			output
,	@oCate2			tinyint			output
,	@oStatus		tinyint			output
,	@oFolder		int				output
,	@oMainImage		bigint			output
,	@oFileExt		char(3)			output
,	@oSubject		nvarchar(100)	output
,	@oContents		nvarchar(max)	output
,	@oAnswers		nvarchar(max)	output
,	@oCreateTime	datetime		output
,	@oPrevWrite		bigint			output
,	@oNextWrite		bigint			output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vNotis		tinyint
	--	,	@vStartCate tinyint = case @pLimitCate when 255 then 0 else @pLimitCate end
	select	@oAccountNo		= 0
		,	@oWriter		= ''
	--	,	@oGameNick		= ''
		,	@oEmail			= ''
		,	@oHostIp		= ''
		,	@oViewCnt		= 0
		,	@oRecmdCnt		= 0
		,	@oAgnstCnt		= 0
		,	@oCate1			= 0
		,	@oCate2			= 0
		,	@oStatus		= 0
		,	@oMainImage		= 0
		,	@oFolder		= ''
		,	@oFileExt		= ''
		,	@oSubject		= ''
		,	@oContents		= ''
		,	@oAnswers		= ''
		,	@oCreateTime	= 0
		,	@oPrevWrite		= 0
		,	@oNextWrite		= 0
		,	@oReturnNo		= 1

	-- 게시물 기본 정보
	update	a
	set		@oViewCnt		= cViewCnt += case @pIsRead when 0 then 1 else 0 end
		,	@oAccountNo		= cAccountNo
		,	@oWriter		= cWriter
		,	@oEmail			= cEmail
		,	@oHostIp		= cHostIp
		,	@vNotis			= cNotis
		,	@oCate1			= isnull(cCate1,0)
		,	@oCate2			= isnull(cCate2,0)
		,	@oStatus		=
							case
								when cRecep = 0 then 1
								when cReply = 1 then 4
								when cReady = 1 then 3
								when cRecep = 1 then 2
							end
		,	@oRecmdCnt		= isnull(cRecmdCnt,0)
		,	@oAgnstCnt		= isnull(cAgnstCnt,0)
		,	@oFolder		= isnull(cFolder,0)
		,	@oMainImage		= isnull(cImage,0)
		,	@oFileExt		= isnull(cExts,0)
		,	@oSubject		= cSubject
		,	@oCreateTime	= cCreateTime
	from	dbo.tArticleInfo as a
	where	cMenuNo			= @pMenuNo
		and	cWriteNo		= @pWriteNo
		and	cPublisher		= @pPublisher
		and	cDrop			= 0

	if @@rowcount = 0
	begin
		select 1
		set @oReturnNo = 2
		return 2
	end


	if @pIsAround = 1
	begin
		if @vNotis > 0 and len(rtrim(@pFilterTxt)) = 0
		begin
			select	@pFilterKey = 6
				,	@pFilterTxt = @vNotis
		end

		-- 앞/뒤 글번호
		exec dbo.uspGetArticleAroundInfo
				@pMenuNo		= @pMenuNo
			,	@pWriteNo		= @pWriteNo
			,	@pPublisher		= @pPublisher
		--	,	@pStartCate		= @vStartCate
		--	,	@pLimitCate		= @pLimitCate
			,	@pLimitDate		= @pLimitDate
			,	@pFilterKey		= @pFilterKey
			,	@pFilterTxt		= @pFilterTxt
			,	@oPrevWrite		= @oPrevWrite	output
			,	@oNextWrite		= @oNextWrite	output
			,	@oReturnNo		= @oReturnNo	output
	end


	-- 게시물 내용
	select	@oContents	= cContents
	from	dbo.tContentsInfo
	where	cMenuNo		= @pMenuNo
		and	cWriteNo	= @pWriteNo
		and	cLangNo		= @pLanguage

	if @pIsQnA = 1
	begin
		-- 답변 게시물 내용
		select	@oAnswers	= cContents
		from	dbo.tContentsInfo
		where	cMenuNo		= @pMenuNo
			and	cWriteNo	= @pWriteNo
			and	cLangNo		= 0
	end

	if @pIsFile = 1
	begin
		-- 첨부파일 목록
		select	cMenuNo
			,	cFileNo
			,	cFileName
			,	cFileExt
			,	cFileSize
		from	dbo.tFileInfo
		where	cWriteNo	= @pWriteNo
			and	cDeleteTime	is null
	end
	else
	begin
		select 1
	end


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare
 @o1 bigint
,@o2 nvarchar(20)
,@o3 varchar(50)
,@o4 varchar(15)
,@o5 int
,@o6 int
,@o7 int
,@o8 tinyint
,@o9 tinyint
,@o10 tinyint
,@o11 int
,@o12 bigint
,@o13 char(3)
,@o14 nvarchar(100)
,@o15 nvarchar(max)
,@o16 nvarchar(max)
,@o17 datetime
,@o18 bigint
,@o19 bigint
,@rt int
,@sp int
exec @sp = dbo.uspGetArticleDetailInfo
 @pMenuNo = 1000001
,@pWriteNo = 22
,@pPublisher = 2
,@pLanguage = 1
--,@pLimitCate = 1
,@pLimitDate = '2015-01-01 00:00:00'
,@pFilterKey = 1
,@pFilterTxt = N''
,@pIsQnA = 0
,@pIsRead = 1
,@pIsFile = 1
,@pIsAround = 1
,@oAccountNo = @o1 out
,@oWriter = @o2 out
,@oEmail = @o3 out
,@oHostIp = @o4 out
,@oViewCnt = @o5 out
,@oRecmdCnt = @o6 out
,@oAgnstCnt = @o7 out
,@oCate1 = @o8 out
,@oCate2 = @o9 out
,@oStatus = @o10 out
,@oFolder = @o11 out
,@oMainImage = @o12 out
,@oFileExt = @o13 out
,@oSubject = @o14 out
,@oContents = @o15 out
,@oAnswers = @o16 out
,@oCreateTime = @o17 out
,@oPrevWrite = @o18 out
,@oNextWrite = @o19 out
,@oReturnNo = @rt out

print  '@oAccountNo		: '+ rtrim(@o1)
print  '@oWriter		: '+ @o2
print  '@oEmail			: '+ isnull(@o3,'null')
print  '@oHostIp		: '+ @o4
print  '@oViewCnt		: '+ rtrim(@o5)
print  '@oRecmdCnt		: '+ rtrim(@o6)
print  '@oAgnstCnt		: '+ rtrim(@o7)
print  '@oCate1			: '+ rtrim(@o8)
print  '@oCate2			: '+ rtrim(@o9)
print  '@oStatus		: '+ rtrim(@o10)
print  '@ocFolder		: '+ rtrim(@o11)
print  '@oMainImage		: '+ rtrim(isnull(@o12,-1))
print  '@oFileExt		: '+ isnull(@o13,'null')
print  '@oSubject		: '+ @o14
print  '@oContents		: '+ @o15
print  '@oAnswers		: '+ @o16
print  '@oCreateTime	: '+ convert(char(23),@o17,121)
print  '@oPrevWrite		: '+ rtrim(@o18)
print  '@oNextWrite		: '+ rtrim(@o19)
print  '@oReturnNo		: '+ rtrim(@rt)
print  '@vReturnNo		: '+ rtrim(@sp)
*/
go

grant execute on dbo.uspGetArticleDetailInfo to [sawebuser]
go


