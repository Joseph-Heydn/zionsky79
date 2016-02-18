use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_EVENT_PRESENT_INFO_C') is null
	exec('create procedure dbo.KWP00305_SG_WS_EVENT_PRESENT_INFO_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_EVENT_PRESENT_INFO_C
go
/******************************************************************************
	name		: KWP00305_SG_WS_EVENT_PRESENT_INFO_C
	description	: 이벤트 선물 추가
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: INSERT error
					-3	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_EVENT_PRESENT_INFO_C
(	@pEventType		tinyint			-- 이벤트 타입
,	@pEventName		nvarchar(16)	-- 이벤트 이름
,	@pNoteText		nvarchar(50)	-- 이벤트 설명
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if @pEventName = '' or @pNoteText = ''
	begin
		set @oReturnNo = -1
		return
	end


	if @pEventType = 1
	begin
		insert into dbo.KWT003_SG_WS_EVENT_PRESENT
			(	cEventNo
			,	cEventName
			,	cNoteText
			,	cCreateTime
			)
		select	isnull(max(cEventNo),0) + 1
			,	@pEventName
			,	@pNoteText
			,	getdate()
		from	dbo.KWT003_SG_WS_EVENT_PRESENT
		where	cEventNo < 1000000001

		if @@error != 0 or @@rowcount = 0
		begin
			set @oReturnNo = -2
			return
		end
	end
	else if @pEventType = 2
	begin
		insert into dbo.KWT003_SG_WS_EVENT_PRESENT
			(	cEventNo
			,	cEventName
			,	cNoteText
			,	cCreateTime
			)
		select	isnull(max(cEventNo),0) + 1
			,	@pEventName
			,	@pNoteText
			,	getdate()
		from	dbo.KWT003_SG_WS_EVENT_PRESENT
		where	cEventNo > 1000000000

		if @@error != 0 or @@rowcount = 0
		begin
			set @oReturnNo = -3
			return
		end
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00305_SG_WS_EVENT_PRESENT_INFO_C
 @pEventType = 1
,@pEventName = ''
,@pNoteText = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00305_SG_WS_EVENT_PRESENT_INFO_C to [opwebuser]
go

