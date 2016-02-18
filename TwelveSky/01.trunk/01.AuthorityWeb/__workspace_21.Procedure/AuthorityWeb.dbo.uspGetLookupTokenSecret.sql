use AuthorityWeb
go
if object_id('dbo.uspGetLookupTokenSecret') is null
	exec ('create procedure dbo.uspGetLookupTokenSecret as select 1')
--	drop procedure dbo.uspGetLookupTokenSecret
go
/******************************************************************************
	Name		: dbo.uspGetLookupTokenSecret
	Description	: api - TokenSecret 찾기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupTokenSecret
(	@pToken			uniqueidentifier
,	@oSecret		char(27)	output
,	@oAccountNo		bigint		output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oSecret	= cSecret
		,	@oAccountNo	= cAccountNo
	from	dbo.tGuestConsumer
	where	cToken		= @pToken

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetLookupTokenSecret to [sawebuser]
go

