use SiteManager
go
if object_id('dbo.KWP00106_SG_WS_GRP_MENU_LIST_D') is null
	exec ('create procedure dbo.KWP00106_SG_WS_GRP_MENU_LIST_D as select 1')
--	drop procedure dbo.KWP00106_SG_WS_GRP_MENU_LIST_D
go
/******************************************************************************
	name		: KWP00106_SG_WS_GRP_MENU_LIST_D
	description	: 권한 그룹에서 제외
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00106_SG_WS_GRP_MENU_LIST_D
(	@pAuthGroup		int
,	@pMenuList		varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	delete	a
	from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE as a with(updlock)
			inner join
			dbo.fnTbl2Int(@pMenuList,'|') as b
		on	a.cMenuNo		= b.cValue
	where	a.cAuthGroup	= @pAuthGroup

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00106_SG_WS_GRP_MENU_LIST_D
 @pAuthGroup = 100200005
,@pMenuList = '100100003|'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00106_SG_WS_GRP_MENU_LIST_D to [opwebuser]
go

