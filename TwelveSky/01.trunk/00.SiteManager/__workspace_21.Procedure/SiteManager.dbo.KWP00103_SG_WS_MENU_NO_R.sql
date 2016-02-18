use SiteManager
go
if object_id('dbo.KWP00103_SG_WS_MENU_NO_R') is null
	exec ('create procedure dbo.KWP00103_SG_WS_MENU_NO_R as select 1')
--	drop procedure dbo.KWP00103_SG_WS_MENU_NO_R
go
/******************************************************************************
	name		: KWP00103_SG_WS_MENU_NO_R
	description	: 관리자페이지 -> 매뉴 코드 읽어오기
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00103_SG_WS_MENU_NO_R
(	@pExecUrl	varchar(120)
,	@oMenuNo	int		output
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oMenuNo	= 0
		,	@oReturnNo	= -1

	if len(@pExecUrl) = 0
	begin
		set @oReturnNo = -1
		return
	end


	select 	@oMenuNo	= cMenuNo
	from	dbo.KWT001_SG_WS_MENU_LIST
	where	cExecUrl	= @pExecUrl
		and	cIsUsed		= 1

	if @@rowcount != 1
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 int
,@SP int
exec dbo.KWP00103_SG_WS_MENU_NO_R
 @pExecUrl = '/APP/SiteManager/siteBaseCode.aspx'
,@oMenuNo = @o1 output
,@oReturnNo = @SP output

print @o1
print @SP
*/
go

grant execute on dbo.KWP00103_SG_WS_MENU_NO_R to [opwebuser]
go


