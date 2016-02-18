use SiteManager
go
if object_id('dbo.KWP00602_SG_WS_STATIS_ACTIVE_USER_LIST_R') is null
	exec ('create procedure dbo.KWP00602_SG_WS_STATIS_ACTIVE_USER_LIST_R as select 1')
--	drop procedure dbo.KWP00602_SG_WS_STATIS_ACTIVE_USER_LIST_R
go
/******************************************************************************
	name		: KWP00602_SG_WS_STATIS_ACTIVE_USER_LIST_R
	description	: Active User List
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-04-06	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00602_SG_WS_STATIS_ACTIVE_USER_LIST_R
(	@pStartDate		int
,	@pFinishDate	int
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	declare	@v_cServerNo tinyint
	set @oReturnNo = -1

	select	a.cWorkDate
		,	isnull(b.cActiveCnt,0) as cActiveCnt
	from	LogMasterLive.dbo.tWorkDateMaster		as a
			left outer join
			LogMasterLive.dbo.tStatisticsActiveUser	as b
		on	b.cWorkDate		= a.cWorkDate
		and	b.cServerNo		= a.cServerNo
	where	a.cWorkDate		between @pStartDate and @pFinishDate
		and	a.cServerNo		= 0
	order by a.cWorkDate



	select	@v_cServerNo	= max(cServerNo)
	from	LogMasterLive.dbo.tStatisticsActiveUser
	where	cWorkDate		between @pStartDate and @pFinishDate

	select	a.cWorkDate
		,	a.cServerNo
		,	isnull(b.cActiveCnt,0) as cActiveCnt
	from	LogMasterLive.dbo.tWorkDateMaster		as a
			left outer join
			LogMasterLive.dbo.tStatisticsActiveUser	as b
		on	b.cWorkDate		= a.cWorkDate
		and	b.cServerNo		= a.cServerNo
	where	a.cWorkDate		between @pStartDate and @pFinishDate
		and	a.cServerNo		between 1 and @v_cServerNo
	order by
			cServerNo
		,	cWorkDate


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00602_SG_WS_STATIS_ACTIVE_USER_LIST_R
 @pStartDate = 20130909
,@pFinishDate = 20131023
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00602_SG_WS_STATIS_ACTIVE_USER_LIST_R to [opwebuser]
go

