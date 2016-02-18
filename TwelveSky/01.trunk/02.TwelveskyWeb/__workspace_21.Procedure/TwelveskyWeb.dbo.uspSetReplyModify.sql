use TwelveskyWeb
go
if object_id('dbo.uspSetReplyModify') is null
	exec ('create procedure dbo.uspSetReplyModify as select 1')
--	drop procedure dbo.uspSetReplyModify
go
/******************************************************************************
	Name		: dbo.uspSetReplyModify
	Description	: 게시물 댓글 수정
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetReplyModify
(	@pMenuNo		int
,	@pWriteNo		bigint
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pCommtNo		bigint
,	@pAccountNo		bigint
,	@pContents		nvarchar(2000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vErrorMsg nvarchar(max) = ''
	set @oReturnNo = 1

	if @pMenuNo = 0 or @pAccountNo = 0 or @pWriteNo = 0
	begin
		set @oReturnNo = -1
		return -1
	end

	if not exists (
		select	1
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cWriteNo	= @pWriteNo
			and	cPublisher	= @pPublisher
			and	cDrop		= 0
	)
	begin
		set @oReturnNo = 2
		return 2
	end


	begin try
		set @oReturnNo = 3
		-- 댓글 수정
		update	a
		set		cComments	= @pContents
			,	cModifyTime	= getdate()
		from	dbo.tCommentInfo as a
		where	cWriteNo	= @pWriteNo
			and	cCommtNo	= @pCommtNo
			and	cAccountNo	= @pAccountNo
			and	cDrop		= 0

		if @@rowcount != 1
		begin
			select	@oReturnNo = -3
				,	@vErrorMsg = '@pWriteNo = '+ rtrim(@pWriteNo)
				,	@vErrorMsg += ', @pCommtNo = '+ rtrim(@pCommtNo)
				,	@vErrorMsg += ', @pAccountNo = '+ rtrim(@pAccountNo)
			raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
		end
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
exec dbo.uspSetReplyModify
 @pMenuNo = 10001
,@pWriteNo = 20002
,@pPublisher = 1
,@pCommtNo = 200001
,@pAccountNo = 1000001
,@pContents = N'이거슨 머신가요??ㅋㅋ'
,@oReturnNo = @rt out

print @rt
*/
go

grant execute on dbo.uspSetReplyModify to [sawebuser]
go

