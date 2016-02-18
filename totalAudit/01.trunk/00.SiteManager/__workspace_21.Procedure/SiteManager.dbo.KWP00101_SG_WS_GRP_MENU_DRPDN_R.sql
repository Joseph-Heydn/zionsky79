use SiteManager
go
if object_id('dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R') is null
	exec ('create procedure dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R as select 1')
--	drop procedure dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R
go
/******************************************************************************
	Name		: KWP00101_SG_WS_GRP_MENU_DRPDN_R
	Description	: 메뉴 그룹 드롭다운 리스트
	Reference	:
	Result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2012-03-11	Hoon-Sik,Jin	1.초기생성
 ******************************************************************************/
alter procedure dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R
(	@pSiteGroup		int
,	@pMode			tinyint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if @pMode = 1
	begin
		select	cSiteGroup
			,	cSiteName
		from	dbo.KWT001_SG_WS_SITE_GROUP_MST
		where 	cSiteGroup	< 2001
			and	cIsUsed		= 1
		order by cSiteGroup
	end

	else
	begin
		select	cCommGroup	as cMenuGroup
			,	cCommName	as cGroupName
			,	cOrderBy
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST
		where 	cSiteGroup	= @pSiteGroup
			and	cIsUsed		= 1
		order by cOrderBy
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
exec dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R
 @pSiteGroup = 1001
,@pMode = 1
,@oReturnNo = 1
*/
go

grant execute on dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R to [opwebuser]
go

