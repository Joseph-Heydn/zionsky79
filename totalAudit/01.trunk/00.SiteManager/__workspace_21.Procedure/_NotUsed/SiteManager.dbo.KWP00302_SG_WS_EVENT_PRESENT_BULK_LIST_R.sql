use SiteManager
go
if object_id('dbo.KWP00302_SG_WS_EVENT_PRESENT_BULK_LIST_R') is null
	exec('create procedure dbo.KWP00302_SG_WS_EVENT_PRESENT_BULK_LIST_R as select 1')
--	drop procedure dbo.KWP00302_SG_WS_EVENT_PRESENT_BULK_LIST_R
go
/******************************************************************************
	name		: KWP00302_SG_WS_EVENT_PRESENT_BULK_LIST_R
	description	: 지정 유저 이벤트 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-11-09	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00302_SG_WS_EVENT_PRESENT_BULK_LIST_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cServerNo
		,	cEventNo
		,	cEventName
		,	cIsFile
	from	dbo.KWT003_SG_WS_EVENT_PRESENT_BULK with(nolock)
	order by cEventNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00302_SG_WS_EVENT_PRESENT_BULK_LIST_R
 @pEventType = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00302_SG_WS_EVENT_PRESENT_BULK_LIST_R to [opwebuser]
go

