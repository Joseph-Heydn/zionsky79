use AuthorityWeb
go
if object_id('dbo.uspGetLookupGameNick') is null
	exec ('create procedure dbo.uspGetLookupGameNick as select 1')
--	drop procedure dbo.uspGetLookupGameNick
go
/******************************************************************************
	Name		: dbo.uspGetLookupGameNick
	Description	: 닉네임 찾기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupGameNick
(	@pAccountNo		bigint
,	@oGameNick		nvarchar(20)	output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oGameNick	= cGameNick
	from	dbo.tGuestConsumer
	where	cAccountNo	= @pAccountNo

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetLookupGameNick to [sawebuser]
go

