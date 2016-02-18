use SiteManager
go
if object_id('dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R') is null
	exec ('create procedure dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R as select 1')
--	drop procedure dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R
go
/******************************************************************************
	Name		: dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R
	Description	: 권한 그룹 드롭다운 리스트
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-12	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R
(	@pAdminNo	int
,	@pMode		tinyint
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vOrderBy int
	set @oReturnNo = -1

	select	@vOrderBy		= a.cOrderBy
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			inner join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as b
		on	b.cAuthGroup	= a.cCommGroup
	where	b.cAdminNo		= @pAdminNo

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	select	cCommGroup	as cAuthGroup
		,	cCommName	as cAuthName
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup	= 2001
		and	cOrderBy	>= @vOrderBy
		and cIsUsed		= 1
	order by cOrderBy


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R
@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R to [opwebuser]
go

