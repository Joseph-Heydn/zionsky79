use TwelveskyWeb
go
if object_id('dbo.uspSetReplyDelete') is null
	exec ('create procedure dbo.uspSetReplyDelete as select 1')
--	drop procedure dbo.uspSetReplyDelete
go
/******************************************************************************
	Name		: dbo.uspSetReplyDelete
	Description	: 게시물 댓글 삭제
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetReplyDelete
(	@pMenuNo		int
,	@pWriteNo		bigint
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pCommtNo		bigint
,	@pAccountNo		bigint
,	@oReplyCnt		int		output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vErrorMsg nvarchar(max) = ''
	select	@oReplyCnt = 0
		,	@oReturnNo = 1

	if @pMenuNo = 0 or @pAccountNo = 0
	begin
		set @oReturnNo = -1
		return -1
	end


	begin try
		begin tran
			set @oReturnNo = 2
			-- 게시물 댓글 수 갱신
			update	a
			set		@oReplyCnt	= cReplyCnt -= 1
			from	dbo.tArticleInfo as a
			where	cMenuNo		= @pMenuNo
				and	cWriteNo	= @pWriteNo
				and	cPublisher	= @pPublisher
				and	cDrop		= 0

			if @@rowcount = 0
			begin
				select	@oReturnNo = -2
					,	@vErrorMsg = '@pMenuNo = '+ rtrim(@pMenuNo)
					,	@vErrorMsg += ', @pWriteNo = '+ rtrim(@pWriteNo)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end


			set @oReturnNo = 3
			-- 댓글 삭제 처리
			update	a
			set		cDrop		= 1
				,	cDeleteTime	= getdate()
			from	dbo.tCommentInfo as a
			where	cWriteNo	= @pWriteNo
				and	cCommtNo	= @pCommtNo
				and	cAccountNo	= @pAccountNo
				and	cDrop		= 0

			if @@rowcount = 0
			begin
				select	@oReturnNo = -3
					,	@vErrorMsg = '@pWriteNo = '+ rtrim(@pWriteNo)
					,	@vErrorMsg += ', @pCommtNo = '+ rtrim(@pCommtNo)
					,	@vErrorMsg += ', @pAccountNo = '+ rtrim(@pAccountNo)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end


			set @oReturnNo = 4
			-- 관리테이블에 댓글 수 갱신
			update	a
			set		cReplyCnt	-= 1
			from	dbo.tBoardMaster as a
			where	cMenuNo		= @pMenuNo
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return 99
	end catch


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare
 @o1 int
,@rt int
exec dbo.uspSetReplyDelete
 @pMenuNo = 10001
,@pWriteNo = 20002
,@pPublisher = 1
,@pCommtNo = 200002
,@pAccountNo = 1000001
,@oReplyCnt = @o1 out
,@oReturnNo = @rt out

print @o1
print @rt
*/
go

grant execute on dbo.uspSetReplyDelete to [sawebuser]
go

