use AuthorityWeb
go
if object_id('dbo.uspGetCheckDupAccountId') is null
	exec ('create procedure dbo.uspGetCheckDupAccountId as select 1')
--	drop procedure dbo.uspGetCheckDupAccountId
go
/******************************************************************************
	Name		: dbo.uspGetCheckDupAccountId
	Description	: 중복 아이디 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCheckDupAccountId
(	@pAccountId		varchar(50)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if exists ( select 1 from dbo.tAccountInfo where cAccountId = @pAccountId )
	begin
		-- 이미 존재함
		set @oReturnNo = 1
		return 1
	end


	-- 사용 가능
	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetCheckDupAccountId to [sawebuser]
go

