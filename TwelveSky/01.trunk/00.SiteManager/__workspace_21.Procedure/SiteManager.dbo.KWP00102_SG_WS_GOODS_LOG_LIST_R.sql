use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R
go
/******************************************************************************
	Name		: dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R
	Description	: 관리자 지급 기록 조회
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 날짜 변환 오류
					-3	: 입력값 오류
					-4	: 접속 로그 생성실패

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-04-21	Hong-Suk,Kim	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R
(	@pStartDate		int
,	@pFinishDate	int
,	@pPlayerNo		bigint
,	@pPublisher		tinyint
,	@pAdminNo		int
,	@pAction		tinyint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	--입력값 검증
	if @pStartDate < 20150501
	begin
		set @oReturnNo = -2
		return
	end

	if @pFinishDate < @pStartDate
	begin
		set @oReturnNo = -3
		return
	end


	select	a.cWorkDate
		,	a.cServerNo
		,	a.cPlayerNo
		,	a.cNickName
		,	a.cPublisher
		,	a.cMailNo
		,	a.cAction
		,	a.cValueNew
		,	a.cValueOld
		,	a.cTryCnt
		,	a.cAdminNo
		,	a.cHostIp
		,	a.cModifyTime
		,	a.cCreateTime
		,	b.cAdminId
	from	dbo.KWT002_SG_WS_GOODS_LOG	as a
			inner join
			dbo.KWT001_SG_WS_MANGR_LIST	as b
		on	a.cAdminNo	= b.cAdminNo
	where	a.cWorkDate		between @pStartDate and @pFinishDate
		and	(a.cAction		= @pAction	or @pAction = 0)
		and	(a.cAdminNo		= @pAdminNo	or @pAdminNo = 0)
/*		and	(a.cPlayerNo	= @pPlayerNo	or @pPlayerNo = 0)
		and	(a.cPublisher	= @pPublisher	or @pPublisher = 0)
		and	a.cAction		= case @pAction when 0 then a.cAction else @pAction end
		and	a.cAdminNo		= case @pAdminNo when 0 then a.cAdminNo else @pAdminNo end
		and	a.cPlayerNo		= case @pPlayerNo when 0 then a.cPlayerNo else @pPlayerNo end
		and	a.cPublisher	= case @pPublisher when 0 then a.cPublisher else @pPublisher end
*/
	if @@rowcount = 0
	begin
		set @oReturnNo = -4
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R
 @pStartDate = 20150522
,@pFinishDate = 20150522
,@pPlayerNo = 0
,@pPublisher = 0
,@pAdminNo = 0
,@pAction = 13
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R to [opwebuser]
go

