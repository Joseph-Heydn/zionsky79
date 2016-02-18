use TwelveskyWeb
go
if object_id('dbo.uspSetArticleWrite') is null
	exec ('create procedure dbo.uspSetArticleWrite as select 1')
--	drop procedure dbo.uspSetArticleWrite
go
/******************************************************************************
	Name		: dbo.uspSetArticleWrite
	Description	: 게시물 작성
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetArticleWrite
(	@pGameNo		int
,	@pMenuNo		int
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pLanguage		tinyint		-- 1:en, 2:th, 3:vn
,	@pCate1			smallint
,	@pCate2			smallint
,	@pAccountNo		bigint
,	@pAccountId		varchar(50)
,	@pWriter		nvarchar(20)
,	@pEmail			varchar(50)
,	@pAgree			bit				-- 1:1 문의 관련 동의
,	@pMainImage		bigint
,	@pFileExt		char(3)
,	@pExtLink		varchar(200)
,	@pHostIp		varchar(15)
,	@pSubject		nvarchar(100)
,	@pSummary		nvarchar(300)	-- 게시글 요약
,	@pContents		nvarchar(max)
,	@oWriteNo		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if @pMenuNo = 0
	begin
		set @oReturnNo = -1
		return -1
	end

	if not exists (
		select	1
		from	dbo.tBoardMaster
		where	cGameNo	= @pGameNo
			and	cMenuNo = @pMenuNo
			and	cIsUsed	= 1
	)
	begin
		set @oReturnNo = -2
		return -2
	end


	begin try
		begin tran
			select	@oReturnNo	= 3
				,	@oWriteNo	= next value for dbo.sWriteNo

			-- 게시물 작성
			insert into dbo.tArticleInfo
				(	cMenuNo
				,	cCate1
				,	cCate2
				,	cWriteNo
				,	cSubject
				,	cPublisher
				,	cAccountNo
				,	cAccountId
				,	cWriter
				,	cEmail
				,	cAgree
				,	cView
				,	cDrop
				,	cRecep
				,	cReady
				,	cReply
				,	cViewCnt
				,	cReplyCnt
				,	cHostIp
				,	cFolder
				,	cImage
				,	cExts
				,	cLink
				,	cSummary
				,	cCreateTime
				)
			values
				(	@pMenuNo
				,	nullif(@pCate1,0)
				,	nullif(@pCate2,0)
				,	@oWriteNo
				,	@pSubject
				,	@pPublisher
				,	@pAccountNo
				,	@pAccountId
				,	@pWriter
				,	nullif(@pEmail,'')
				,	@pAgree
				,	1
				,	0
				,	0
				,	0
				,	0
				,	0
				,	0
				,	@pHostIp
				,	iif(@pMainImage=0,null,@pMenuNo)
				,	nullif(@pMainImage,0)
				,	nullif(@pFileExt,'')
				,	nullif(@pExtLink,'')
				,	nullif(@pSummary,'')
				,	getdate()
				)


			set @oReturnNo = 4
			-- 본문 작성
			insert into dbo.tContentsInfo
				(	cMenuNo
				,	cWriteNo
				,	cLangNo
				,	cContents
				,	cView
				,	cDrop
				,	cCreateTime
				)
			values
				(	@pMenuNo
				,	@oWriteNo
				,	@pLanguage
				,	@pContents
				,	1
				,	0
				,	getdate()
				)


			set @oReturnNo = 5
			-- 게시물 수 증가
			update	a
			set		cWriteCnt	+= 1
			from	dbo.tBoardMaster as a
			where	cMenuNo		= @pMenuNo
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare
 @o1 bigint
,@sp int
,@rt int
exec @sp = dbo.uspSetArticleWrite
 @pGameNo = 2016001
,@pMenuNo = 10001
,@pPublisher = 1
,@pLanguage = 1
,@pCate1 = 1
,@pCate2 = 1
,@pSubject = N'테스트'
,@pSummary = N''
,@pAccountNo = 1000001
,@pAccountId = 'zephyrus'
,@pWriter = N'어쩌라고'
,@pEmail = 'zephyrus@gmail.com'
,@pAgree = 0
,@pMainImage = 0
,@pFileExt = ''
,@pHostIp = '10.181.192.114'
,@pContents = N'테스트 게시물 확인'
,@oWriteNo = @o1 out
,@oReturnNo = @rt out

print @o1
print @sp
print @rt
*/
go

grant execute on dbo.uspSetArticleWrite to [sawebuser]
go

