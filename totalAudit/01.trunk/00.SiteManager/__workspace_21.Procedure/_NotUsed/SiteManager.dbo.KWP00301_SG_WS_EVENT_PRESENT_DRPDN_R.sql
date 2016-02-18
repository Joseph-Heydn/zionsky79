use SiteManager
go
if object_id('dbo.KWP00301_SG_WS_EVENT_PRESENT_DRPDN_R') is null
	exec('create procedure dbo.KWP00301_SG_WS_EVENT_PRESENT_DRPDN_R as select 1')
--	drop procedure dbo.KWP00301_SG_WS_EVENT_PRESENT_DRPDN_R
go
/******************************************************************************
	name		: KWP00301_SG_WS_EVENT_PRESENT_DRPDN_R
	description	: 이벤트 번호 드롭다운 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2014-02-01	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00301_SG_WS_EVENT_PRESENT_DRPDN_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cEventNo
		,	rtrim(cEventNo) +'.'+ cEventName as cEventName
	from	dbo.KWT003_SG_WS_EVENT_PRESENT with(nolock)
	order by cEventNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00301_SG_WS_EVENT_PRESENT_DRPDN_R
 @oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00301_SG_WS_EVENT_PRESENT_DRPDN_R to [opwebuser]
go

