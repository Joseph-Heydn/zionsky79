use SiteManager
go
if object_id('dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R') is null
	exec ('create procedure dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R as select 1')
--	drop procedure dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R
go
/******************************************************************************
	Name		: KWP00101_SG_WS_GRP_DEPT_DRPDN_R
	Description	: 부서 그룹 드롭다운 리스트
	Reference	:
	Result		: @oReturnNo
					 0	: Success
					-1	: initialize error

  Ver		Date		Author			Description
  --------	----------	--------------	------------------------------------
	1.0		2012-03-11	Hoon-Sik,Jin	1.초기생성
 ******************************************************************************/
alter procedure dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	-- 부서 그룹
	select	cCommGroup	as cDeptNo
		,	cCommName	as cDeptName
		,	cOrderBy
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
	where	cSiteGroup	= 3001
		and cIsUsed		= 1
	order by cOrderBy


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
exec dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R
@oReturnNo = 1
*/
go

grant execute on dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R to [opwebuser]
go

