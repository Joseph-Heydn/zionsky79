use AuthorityWeb
go
if object_id('dbo.uspGetCheckDupEmail') is null
	exec ('create procedure dbo.uspGetCheckDupEmail as select 1')
--	drop procedure dbo.uspGetCheckDupEmail
go
/******************************************************************************
	Name		: dbo.uspGetCheckDupEmail
	Description	: 중복 이메일 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCheckDupEmail
(	@pAccountNo		bigint
,	@pEmail			varchar(50)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if exists ( select 1 from dbo.tAccountInfo where cAccountNo != @pAccountNo and cEmail = @pEmail and cDeleteTime is null )
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @sp int
,@rt int
exec @sp = dbo.uspGetCheckDupEmail
 @pAccountNo = 100000001
,@pEmail = 'mission2hs@daum.net'
,@oReturnNo = @rt out

print @sp
print @rt
*/
go

grant execute on dbo.uspGetCheckDupEmail to [sawebuser]
go

