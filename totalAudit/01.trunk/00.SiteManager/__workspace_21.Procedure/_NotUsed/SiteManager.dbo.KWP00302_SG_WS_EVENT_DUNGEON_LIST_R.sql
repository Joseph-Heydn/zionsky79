use SiteManager
go
if object_id('dbo.KWP00302_SG_WS_EVENT_DUNGEON_LIST_R') is null
	exec('create procedure dbo.KWP00302_SG_WS_EVENT_DUNGEON_LIST_R as select 1')
--	drop procedure dbo.KWP00302_SG_WS_EVENT_DUNGEON_LIST_R
go
/******************************************************************************
	name		: dbo.KWP00302_SG_WS_EVENT_DUNGEON_LIST_R
	description	: 이벤트 던전 관리 테이블
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-11-01	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00302_SG_WS_EVENT_DUNGEON_LIST_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cEventNo
		,	cEventName
		,	cCreateTime
	from	dbo.KWT003_SG_WS_EVENT_DUNGEON with(nolock)
	order by cEventNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00302_SG_WS_EVENT_DUNGEON_LIST_R
@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00302_SG_WS_EVENT_DUNGEON_LIST_R to [opwebuser]
go

