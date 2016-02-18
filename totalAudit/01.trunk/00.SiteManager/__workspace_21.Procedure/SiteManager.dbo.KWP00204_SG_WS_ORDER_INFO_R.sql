use SiteManager
go
if object_id('dbo.KWP00204_SG_WS_ORDER_INFO_R') is null
	exec ('create procedure dbo.KWP00204_SG_WS_ORDER_INFO_R as select 1')
--	drop procedure dbo.KWP00204_SG_WS_ORDER_INFO_R
go
/******************************************************************************
	name		: KWP00204_SG_WS_ORDER_INFO_R
	description	: 주문번호에 해당하는 유저번호 찾기
	reference	:
	result		: @oReturnNo
					 0	: Success
					 1	: 검색된 유저번호 없음
					-1	: initialize error
					-2	: 주문번호 오류
					-3	: 검색 오류

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00204_SG_WS_ORDER_INFO_R
(	@pOrderNo		varchar(64)
,	@pStartDate		int
,	@pFinishDate	int
,	@oWorkDate		int			output
,	@oWorldNo		tinyint		output
,	@oPlayerNo		bigint		output
,	@oCreateTime	datetime	output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	select	@oWorkDate		= 0
		,	@oWorldNo		= 0
		,	@oPlayerNo		= 0
		,	@oCreateTime	= 0
		,	@oReturnNo		= -1

	select	top 1
			@oWorkDate		= cWorkDate
		,	@oWorldNo		= cServerNo
		,	@oPlayerNo		= cAccountNo
		,	@oCreateTime	= cCreateTime
	from	LogMasterLive.dbo.tGameLog_15 with(nolock)
	where	cText4			= @pOrderNo
		and	cLogType		= 20050
		and	cWorkDate		between @pStartDate and @pFinishDate
	option (recompile)

	if isnull(@oPlayerNo,0) = 0
	begin
		set @oReturnNo = 1
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 int
,@o2 int
,@o3 bigint
,@o4 datetime
,@sp int
exec dbo.KWP00204_SG_WS_ORDER_INFO_R
 @pOrderNo = '12999763169054705758.1339841401669214'
,@pStartDate = '2013-04-01'
,@pFinishDate = '2013-04-10'
,@oWorkDate = @o1 output
,@oWorldNo = @o2 output
,@oPlayerNo = @o3 output
,@oCreateTime = @o4 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @sp
*/
go

grant execute on dbo.KWP00204_SG_WS_ORDER_INFO_R to [opwebuser]
go

