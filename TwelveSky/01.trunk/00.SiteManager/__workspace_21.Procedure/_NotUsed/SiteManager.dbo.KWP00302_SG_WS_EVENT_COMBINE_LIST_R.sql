use SiteManager
go
if object_id('dbo.KWP00302_SG_WS_EVENT_COMBINE_LIST_R') is null
	exec('create procedure dbo.KWP00302_SG_WS_EVENT_COMBINE_LIST_R as select 1')
--	drop procedure dbo.KWP00302_SG_WS_EVENT_COMBINE_LIST_R
go
/******************************************************************************
	name		: KWP00302_SG_WS_EVENT_COMBINE_LIST_R
	description	: 이벤트 조합 목록
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00302_SG_WS_EVENT_COMBINE_LIST_R
(	@pServerNo	tinyint
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cEventNo
		,	convert(char(1),cEventType) as cEventType
		,	cEventName
	from	dbo.KWT003_SG_WS_EVENT_COMBINE with(nolock)
	order by cEventNo desc


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00302_SG_WS_EVENT_COMBINE_LIST_R
 @pServerNo = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00302_SG_WS_EVENT_COMBINE_LIST_R to [opwebuser]
go

