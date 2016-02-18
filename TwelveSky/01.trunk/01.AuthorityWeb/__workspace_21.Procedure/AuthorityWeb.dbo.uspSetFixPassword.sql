use AuthorityWeb
go
if object_id('dbo.uspSetFixPassword') is null
	exec ('create procedure dbo.uspSetFixPassword as select 1')
--	drop procedure dbo.uspSetFixPassword
go
/******************************************************************************
	Name		: dbo.uspSetFixPassword
	Description	: 비밀번호 변경
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixPassword
(	@pAccountNo		bigint
,	@pPassword		char(32)
,	@pNewPassword	char(32)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vPassword binary(70)
	set @oReturnNo = -1

	select	@vPassword	= cPassword
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo
		and	cStatus		= 1

	if pwdcompare(@pPassword, @vPassword) = 0
	begin
		set @oReturnNo = -2
		return -2
	end


	begin try
		set @oReturnNo = 3
		update	a
		set		cPassword	= pwdencrypt(@pNewPassword)
		from	dbo.tAccountInfo as a
		where	cAccountNo	= @pAccountNo
			and	cStatus		= 1
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
go

grant execute on dbo.uspSetFixPassword to [sawebuser]
go

