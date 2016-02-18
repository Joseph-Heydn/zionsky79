use AuthorityWeb
go
if object_id('dbo.uspGetLookupAccountNo') is null
	exec ('create procedure dbo.uspGetLookupAccountNo as select 1')
--	drop procedure dbo.uspGetLookupAccountNo
go
/******************************************************************************
	Name		: dbo.uspGetLookupAccountNo
	Description	: api - 회원번호 찾기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupAccountNo
(	@pToken			uniqueidentifier
,	@oAccountNo		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oAccountNo	= cAccountNo
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

grant execute on dbo.uspGetLookupAccountNo to [sawebuser]
go

