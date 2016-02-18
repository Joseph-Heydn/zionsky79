use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R
go
/******************************************************************************
	Name		: dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R
	Description	: 관리자 액션 기록 조회
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 날짜 변환 오류
					-3	: 입력값 오류
					-4	: 접속 로그 생성실패

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-04-02	Kim, Hongsuk	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R
(	@pStartDate		int
,	@pFinishDate	int
,	@pAdminNo		int
,	@pMenuNo		int
,	@oReturnNo		int		output

) as
begin
	set nocount ON
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	--입력값 검증
	if @pStartDate < 20150501
	begin
		set @oReturnNo = -3
		return
	end

	if @pFinishDate < @pStartDate
	begin
		set @oReturnNo = -3
		return
	end

	if @pMenuNo < -1
	begin
		set @oReturnNo = -3
		return
	end


	create table #tmpFilterManagerLogs
	(	cLogs bigint not null
	)

	if @pMenuNo > 0 and @pAdminNo > 0
	begin
		insert into #tmpFilterManagerLogs
		select	cLogs
		from	dbo.KWT001_SG_WS_MANGR_LOG
		where	cWorkDate	between @pStartDate and @pFinishDate
			and	cAdminNo	= @pAdminNo
			and	cMenuNo		= @pMenuNo
	end
	else if @pMenuNo > 0 and @pAdminNo = 0
	begin
		insert into #tmpFilterManagerLogs
		select	cLogs
		from	dbo.KWT001_SG_WS_MANGR_LOG
		where	cWorkDate	between @pStartDate and @pFinishDate
			and	cAdminNo	> 0
			and	cMenuNo		= @pMenuNo
	end
	else
	begin
		insert into #tmpFilterManagerLogs
		select	cLogs
		from	dbo.KWT001_SG_WS_MANGR_LOG
		where	cWorkDate	between @pStartDate and @pFinishDate
			and	cAdminNo	> 0
			and	cMenuNo		> 0
	end

	if @@rowcount = 0
	begin
		set @oReturnNo = -4
		return
	end


	select	a.cLogs
		,	a.cAdminNo
		,	b.cAdminId as cAdminId
		,	a.cMenuNo
		,	isnull(c.cMenuName,'login') as cMenuName
		,	a.cHttpGet
		,	a.cHttpPost
		,	a.cReferer
		,	a.cHostIp
		,	a.cCreateTime
	from	#tmpFilterManagerLogs as s
			inner join
			dbo.KWT001_SG_WS_MANGR_LOG as a
		on	a.cLogs		= s.cLogs
			left outer join
			dbo.KWT001_SG_WS_MANGR_LIST	as b
		on	b.cAdminNo	= a.cAdminNo
			left outer join
			dbo.KWT001_SG_WS_MENU_LIST as c
		on	c.cMenuNo	= a.cMenuNo

	if @@rowcount = 0
	begin
		set @oReturnNo = -5
		return
	end


	drop table #tmpFilterManagerLogs

	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R
 @pStartDate = 20150623
,@pFinishDate = 20150629
,@pAdminNo = 100000001
,@pMenuNo = 1009002
,@oReturnNo = @sp output

print @sp
set statistics io off
*/
go

grant execute on dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R to [opwebuser]
go

