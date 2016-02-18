use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_EVENT_DUNGEON_INFO_C') is null
	exec('create procedure dbo.KWP00305_SG_WS_EVENT_DUNGEON_INFO_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_EVENT_DUNGEON_INFO_C
go
/******************************************************************************
	name		: dbo.KWP00305_SG_WS_EVENT_DUNGEON_INFO_C
	description	: 이벤트 던전 관리 테이블
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 이미 존재하는 이벤트 번호
					-3	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-11-02	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_EVENT_DUNGEON_INFO_C
(	@pEventNo		tinyint
,	@pEventName		nvarchar(16)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if exists (
		select	top 1 1
		from	dbo.KWT003_SG_WS_EVENT_DUNGEON
		where	cEventNo = @pEventNo
	)
	begin
		set @oReturnNo = -2
		return
	end


	insert into dbo.KWT003_SG_WS_EVENT_DUNGEON
		(	cEventNo
		,	cEventName
		,	cCreateTime
		)
	select	isnull(nullif(@pEventNo,0),isnull(max(cEventNo),0) + 1)
		,	@pEventName
		,	getdate()
	from	dbo.KWT003_SG_WS_EVENT_DUNGEON

	if @@error != 0
	begin
		set @oReturnNo = -3
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00305_SG_WS_EVENT_DUNGEON_INFO_C
 @pEventName = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00305_SG_WS_EVENT_DUNGEON_INFO_C to [opwebuser]
go

