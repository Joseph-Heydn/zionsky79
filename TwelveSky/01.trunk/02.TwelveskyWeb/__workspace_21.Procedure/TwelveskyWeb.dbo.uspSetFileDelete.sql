use TwelveskyWeb
go
if object_id('dbo.uspSetFileDelete') is null
	exec ('create procedure dbo.uspSetFileDelete as select 1')
--	drop procedure dbo.uspSetFileDelete
go
/******************************************************************************
	Name		: dbo.uspSetFileDelete
	Description	: 파일 삭제
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFileDelete
(	@pWriteNo		bigint
,	@pFileNo		bigint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted
	set @oReturnNo = 1

	begin try
		set @oReturnNo = 2
		-- 파일 삭제 처리
		update	a
		set		cDeleteTime	= getdate()
		from	dbo.tFileInfo as a
		where	cWriteNo	= @pWriteNo
			and	cFileNo		= @pFileNo
			and	cDeleteTime	is null
	end try

	begin catch
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
 @sp int
,@rt int
exec @sp = dbo.uspSetFileDelete
 @pWriteNo = 1
,@pFileNo = 700000001
,@oReturnNo = @rt out

print @sp
print @rt
*/
go

grant execute on dbo.uspSetFileDelete to [sawebuser]
go

