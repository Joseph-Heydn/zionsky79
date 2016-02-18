use TwelveskyWeb
go
if object_id('dbo.uspSetArticleModify') is null
	exec ('create procedure dbo.uspSetArticleModify as select 1')
--	drop procedure dbo.uspSetArticleModify
go
/******************************************************************************
	Name		: dbo.uspSetArticleModify
	Description	: 게시물 변경
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetArticleModify
(	@pGameNo		int
,	@pMenuNo		int
,	@pWriteNo		bigint
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pLanguage		tinyint		-- 1:en, 2:ph, 3:vn
,	@pCate1			tinyint
,	@pCate2			tinyint
,	@pAccountNo		bigint
,	@pAgree			bit				-- 1:1 문의 관련 동의
,	@pMainImage		bigint
,	@pFileExt		char(3)
,	@pExtLink		varchar(100)
,	@pHostIp		varchar(15)
,	@pSubject		nvarchar(100)
,	@pSummary		nvarchar(300)	-- 게시글 요약
,	@pContents		nvarchar(max)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vErrorMsg nvarchar(max) = ''
	set @oReturnNo = 1

	if @pMenuNo = 0 or @pAccountNo = 0
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
			set @oReturnNo = 3
			-- 게시물 수정
			update	a
			set		cCate1		= nullif(@pCate1,0)
				,	cCate2		= nullif(@pCate2,0)
				,	cSubject	= @pSubject
				,	cSummary	= nullif(@pSummary,'')
				,	cAgree		= @pAgree
				,	cFolder		= iif(isnull(cImage,0) = @pMainImage, cFolder, nullif(@pMenuNo,0))
				,	cImage		= nullif(@pMainImage,0)
				,	cExts		= nullif(@pFileExt,'')
				,	cLink		= nullif(@pExtLink,'')
				,	cHostIp		= @pHostIp
				,	cModifyTime	= getdate()
			from	dbo.tArticleInfo as a
			where	cMenuNo		= @pMenuNo
				and	cPublisher	= @pPublisher
				and	cWriteNo	= @pWriteNo
				and	cAccountNo	= @pAccountNo
				and	cDrop		= 0

			if @@rowcount = 0
			begin
				select	@oReturnNo = -3
					,	@vErrorMsg = '@pMenuNo = '+ rtrim(@pMenuNo)
					,	@vErrorMsg += ', @pWriteNo = '+ rtrim(@pWriteNo)
					,	@vErrorMsg += ', @pAccountNo = '+ rtrim(@pAccountNo)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end


			set @oReturnNo = 4
			-- 게시물 수정
			update	a
			set		cContents	= @pContents
			from	dbo.tContentsInfo as a
			where	cMenuNo		= @pMenuNo
				and	cWriteNo	= @pWriteNo
				and	cLangNo		= @pLanguage
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
declare @rt int
exec dbo.uspSetArticleModify
 @pGameNo = 2016001
,@pMenuNo = 10001
,@pWriteNo = 20002
,@pPublisher = 1
,@pCate1 = 0
,@pCate2 = 0
,@pSubject = N'테스트2'
,@pSummary = ''
,@pAccountNo = 1000001
,@pAgree = 0
,@pMainImage = null
,@pFileExt = null
,@pHostIp = '10.181.192.115'
,@pContents = '이거 잘 되나요??ㅋㅋ'
,@oReturnNo = @rt out

print @rt
*/
go

grant execute on dbo.uspSetArticleModify to [sawebuser]
go

