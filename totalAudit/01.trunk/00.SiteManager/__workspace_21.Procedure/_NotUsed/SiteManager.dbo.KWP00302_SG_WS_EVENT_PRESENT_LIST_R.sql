use SiteManager
go
if object_id('dbo.KWP00302_SG_WS_EVENT_PRESENT_LIST_R') is null
	exec('create procedure dbo.KWP00302_SG_WS_EVENT_PRESENT_LIST_R as select 1')
--	drop procedure dbo.KWP00302_SG_WS_EVENT_PRESENT_LIST_R
go
/******************************************************************************
	name		: KWP00302_SG_WS_EVENT_PRESENT_LIST_R
	description	: 이벤트 기본 정보 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00302_SG_WS_EVENT_PRESENT_LIST_R
(	@pEventType		tinyint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if @pEventType = 1
	begin
		select	cEventNo
			,	cEventName
			,	cCreateTime
		from	dbo.KWT003_SG_WS_EVENT_PRESENT
		where	cEventNo < 1000000001
		order by cEventNo desc
	end
	else if @pEventType = 2
	begin
		select	cEventNo
			,	cEventName
			,	cCreateTime
		from	dbo.KWT003_SG_WS_EVENT_PRESENT
		where	cEventNo > 1000000000
		order by cEventNo desc
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00302_SG_WS_EVENT_PRESENT_LIST_R
 @pEventType = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00302_SG_WS_EVENT_PRESENT_LIST_R to [opwebuser]
go

