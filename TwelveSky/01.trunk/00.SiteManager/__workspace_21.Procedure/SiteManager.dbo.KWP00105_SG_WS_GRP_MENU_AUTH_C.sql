use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C
go
/******************************************************************************
	name		: KWP00105_SG_WS_GRP_MENU_AUTH_C
	description	: 관리자 메뉴 권한 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C
(	@pAdminNo		int
,	@pAuthGroup		int
,	@pMenuList		varchar(4000)
,	@pWriteList		varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_MENU_GROUP_ROLE
		(	cAuthGroup
		,	cMenuGroup
		,	cMenuNo
		,	cIsRead
		,	cIsWrite
		,	cUpdaterNo
		,	cCreateTime
		)
	select	@pAuthGroup
		,	c.cMenuGroup
		,	c.cMenuNo
		,	1
		,	case when b.cValue is null then 0 else 1 end
		,	@pAdminNo
		,	@vGetDate
	from	dbo.fnTbl2Int(@pMenuList,'|') as a
			left outer join
			dbo.fnTbl2Int(@pWriteList,'|') as b
		on	a.cValue		= b.cValue
			inner join
			dbo.KWT001_SG_WS_MENU_LIST as c
		on	c.cMenuNo		= a.cValue
			left outer join
			dbo.KWT001_SG_WS_MENU_GROUP_ROLE as d
		on	d.cMenuNo		= a.cValue
		and	d.cAuthGroup	= @pAuthGroup
	where	d.cMenuNo		is null

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
exec dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C
 @pAdminNo = 100000001
,@pAuthGroup = 100200005
,@pMenuList = '100100003|'
,@pWriteList = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C to [opwebuser]
go

