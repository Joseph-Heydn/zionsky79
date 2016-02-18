use TwelveskyWeb
go
if object_id('dbo.uspSetArticleDelete') is null
	exec ('create procedure dbo.uspSetArticleDelete as select 1')
--	drop procedure dbo.uspSetArticleDelete
go
/******************************************************************************
	Name		: dbo.uspSetArticleDelete
	Description	: 게시물 삭제
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetArticleDelete
(	@pMenuNo		int
,	@pWriteNo		bigint
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pLangNo		tinyint		-- 1:en, 2:ph, 3:vn
,	@pAccountNo		bigint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vReplyCnt int
		,	@vErrorMsg nvarchar(max) = ''
	set @oReturnNo = 1

	if @pMenuNo = 0 or @pAccountNo = 0
	begin
		set @oReturnNo = -1
		return -1
	end


	begin try
		begin tran
			set @oReturnNo = 2
			-- 글 삭제처리
			update	a
			set		@vReplyCnt	= cReplyCnt
				,	cDrop		= 1
				,	cView		= 0
				,	cDeleteTime = getdate()
			from	dbo.tArticleInfo as a
			where	cMenuNo		= @pMenuNo
				and	cWriteNo	= @pWriteNo
				and	cPublisher	= @pPublisher
				and	cAccountNo	= @pAccountNo
				and	cDrop		= 0

			if @@rowcount = 0
			begin
				select	@oReturnNo = -2
					,	@vErrorMsg = '@pMenuNo = '+ rtrim(@pMenuNo)
					,	@vErrorMsg += ', @pWriteNo = '+ rtrim(@pWriteNo)
					,	@vErrorMsg += ', @pAccountNo = '+ rtrim(@pAccountNo)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end


			set @oReturnNo = 3
			-- 글 삭제처리
			update	a
			set		cDrop		= 1
				,	cDeleteTime = getdate()
			from	dbo.tContentsInfo as a
			where	cMenuNo		= @pMenuNo
				and	cWriteNo	= @pWriteNo
				and	cLangNo		= @pLangNo
				and	cDrop		= 0


			set @oReturnNo = 4
			-- 게시물 수 감소
			update	a
			set		cWriteCnt	-= 1
				,	cReplyCnt	-= @vReplyCnt
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
declare @sp int
exec dbo.uspSetArticleDelete
 @pMenuNo = 10001
,@pWriteNo = 1000001
,@pPublisher = 1
,@pAccountNo = 1000001
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.uspSetArticleDelete to [sawebuser]
go

