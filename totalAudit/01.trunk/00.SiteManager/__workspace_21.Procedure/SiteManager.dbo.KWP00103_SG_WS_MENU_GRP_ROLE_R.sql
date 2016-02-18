use SiteManager
go
if object_id('dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R') is null
	exec ('create procedure dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R as select 1')
--	drop procedure dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R
go
/******************************************************************************
	Name		: dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R
	Description	: 접근하는 페이지가 존재하는지, 권한이 있는지 확인
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-12	Hoon-Sik,Jin	1.CREATE
 *******************************************************************************/
alter procedure dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R
(	@pAuthGroup		int
,	@pMenuNo		int
,	@oMenuGroup		int				output
,	@oGroupName		nvarchar(20)	output
,	@oMenuName		nvarchar(20)	output
,	@oExecUrl		varchar(120)	output
,	@oNoteText		nvarchar(50)	output
,	@oIsUsed		bit				output
,	@oIsRead		bit				output
,	@oIsWrite		bit				output
,	@oReturnNo		int 			output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oMenuName	= ''
		,	@oGroupName	= ''
		,	@oIsUsed	= ''
		,	@oExecUrl	= ''
		,	@oNoteText	= ''
		,	@oMenuGroup	= 0
		,	@oIsUsed	= 0
		,	@oIsRead	= 0
		,	@oIsWrite	= 0
		,	@oReturnNo	= -1

	select	@oMenuName		= b.cMenuName
		,	@oMenuGroup		= b.cMenuGroup
		,	@oGroupName		= c.cCommName
		,	@oIsUsed		= b.cIsUsed
		,	@oExecUrl		= b.cExecUrl
		,	@oNoteText		= b.cNoteText
		,	@oIsUsed		= b.cIsUsed
		,	@oIsRead		= a.cIsRead
		,	@oIsWrite		= a.cIsWrite
	from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE as a
			inner join
			dbo.KWT001_SG_WS_MENU_LIST as b
		on	b.cMenuNo		= a.cMenuNo
		and	b.cMenuGroup	= a.cMenuGroup
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST as c
		on	c.cCommGroup	= b.cMenuGroup
		and	c.cSiteGroup	> 0
	where	a.cAuthGroup	= @pAuthGroup
		and	a.cMenuNo		= @pMenuNo

	if @@rowcount != 1
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare
 @o1 nvarchar(20)
,@o2 int
,@o3 nvarchar(20)
,@o4 varchar(120)
,@o5 nvarchar(100)
,@o6 bit
,@o7 bit
,@o8 bit
,@sp int
exec dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R
 @pAuthGroup = 2001002
,@pMenuNo = 1001000
,@oMenuName = @o1 out
,@oMenuGroup = @o2 out
,@oGroupName = @o3 out
,@oExecUrl = @o4 out
,@oNoteText = @o5 out
,@oIsUsed = @o6 out
,@oIsRead = @o7 out
,@oIsWrite = @o8 out
,@oReturnNo = @sp output

print  '@oMenuName	: '+ rtrim(@o1)
print  '@oMenuGroup	: '+ rtrim(@o2)
print  '@oGroupName	: '+ rtrim(@o3)
print  '@oExecUrl	: '+ rtrim(@o4)
print  '@oNoteText	: '+ rtrim(@o5)
print  '@oIsUsed	: '+ rtrim(@o6)
print  '@oIsRead	: '+ rtrim(@o7)
print  '@oIsWrite	: '+ rtrim(@o8)
print  '@oReturnNo	: '+ rtrim(@sp)
*/
go

grant execute on dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R to [opwebuser]
go

