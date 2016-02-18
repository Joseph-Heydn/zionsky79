use AuthorityWeb
go
if object_id('dbo.uspGetCheckDupNickName') is null
	exec ('create procedure dbo.uspGetCheckDupNickName as select 1')
--	drop procedure dbo.uspGetCheckDupNickName
go
/******************************************************************************
	Name		: dbo.uspGetCheckDupNickName
	Description	: 중복 닉네임 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCheckDupNickName
(	@pNickName		nvarchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if exists ( select 1 from dbo.tAccountInfo where cNickName = @pNickName )
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetCheckDupNickName to [sawebuser]
go

