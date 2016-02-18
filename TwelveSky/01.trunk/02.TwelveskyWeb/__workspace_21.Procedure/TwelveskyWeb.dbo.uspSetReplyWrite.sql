use TwelveskyWeb
go
if object_id('dbo.uspSetReplyWrite') is null
	exec ('create procedure dbo.uspSetReplyWrite as select 1')
--	drop procedure dbo.uspSetReplyWrite
go
/******************************************************************************
	Name		: dbo.uspSetReplyWrite
	Description	: 게시물 댓글 작성
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetReplyWrite
(	@pMenuNo		int
,	@pWriteNo		bigint
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pAccountNo		bigint
,	@pAccountId		varchar(20)
,	@pWriter		nvarchar(20)
,	@pHostIp		varchar(15)
,	@pContents		nvarchar(2000)
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

	if @pMenuNo = 0 or @pAccountNo = 0 or @pWriteNo = 0
	begin
		set @oReturnNo = -1
		return -1
	end


	begin try
		begin tran
			set @oReturnNo = 2
			-- 댓글 수 갱신
			update	a
			set		@oReplyCnt	= cReplyCnt += 1
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
			-- 댓글 작성
			insert into dbo.tCommentInfo
				(	cMenuNo
				,	cWriteNo
				,	cCommtNo
				,	cAccountNo
				,	cAccountId
				,	cWriter
				,	cComments
				,	cHostIp
				,	cView
				,	cDrop
				,	cCreateTime
				)
			values
				(	@pMenuNo
				,	@pWriteNo
				,	next value for dbo.sCommtNo
				,	@pAccountNo
				,	@pAccountId
				,	@pWriter
				,	@pContents
				,	@pHostIp
				,	1
				,	0
				,	getdate()
				)

			if @@rowcount = 0
			begin
				select	@oReturnNo = -3
					,	@vErrorMsg = '@pMenuNo = '+ rtrim(@pMenuNo)
					,	@vErrorMsg += ', @pWriteNo = '+ rtrim(@pWriteNo)
					,	@vErrorMsg += ', @pAccountNo = '+ rtrim(@pAccountNo)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end


			set @oReturnNo = 3
			-- 관리테이블에 댓글 수 갱신
			update	a
			set		cReplyCnt	+= 1
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
 @o1 int
,@rt int
exec dbo.uspSetReplyWrite
 @pMenuNo = 1000007
,@pWriteNo = 100001
,@pPublisher = 1
,@pAccountNo = 1000001
,@pAccountId = 'zephyrus'
,@pWriter = N'어쩌라고'
,@pHostIp = '10.181.192.114'
,@pContents = N'과연 나는 어디로 가야 하는건가??'
,@oReplyCnt = @o1 out
,@oReturnNo = @rt out

print @o1
print @rt
*/
go

grant execute on dbo.uspSetReplyWrite to [sawebuser]
go

