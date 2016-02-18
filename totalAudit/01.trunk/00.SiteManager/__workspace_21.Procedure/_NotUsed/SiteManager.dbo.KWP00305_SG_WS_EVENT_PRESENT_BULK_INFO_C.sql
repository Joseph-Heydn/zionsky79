use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_EVENT_PRESENT_BULK_INFO_C') is null
	exec('create procedure dbo.KWP00305_SG_WS_EVENT_PRESENT_BULK_INFO_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_EVENT_PRESENT_BULK_INFO_C
go
/******************************************************************************
	name		: KWP00305_SG_WS_EVENT_PRESENT_BULK_INFO_C
	description	: 지정 유저 이벤트 추가
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 파라미터 error
					-3	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-11-09	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_EVENT_PRESENT_BULK_INFO_C
(	@pServerNo		tinyint
,	@pEventName		nvarchar(16)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	if @pEventName = ''
	begin
		set @oReturnNo = -2
		return
	end


	insert into dbo.KWT003_SG_WS_EVENT_PRESENT_BULK
		(	cServerNo
		,	cEventName
		,	cIsFile
		,	cCreateTime
		)
	values
		(	@pServerNo
		,	@pEventName
		,	0
		,	getdate()
		)

	if @@error != 0 or @@rowcount = 0
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
exec dbo.KWP00305_SG_WS_EVENT_PRESENT_BULK_INFO_C
 @pEventType = 1
,@pEventName = ''
,@pNoteText = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00305_SG_WS_EVENT_PRESENT_BULK_INFO_C to [opwebuser]
go

