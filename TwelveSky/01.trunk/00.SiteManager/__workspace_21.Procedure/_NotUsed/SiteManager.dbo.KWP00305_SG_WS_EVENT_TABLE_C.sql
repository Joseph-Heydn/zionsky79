use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_EVENT_TABLE_C') is null
	exec('create procedure dbo.KWP00305_SG_WS_EVENT_TABLE_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_EVENT_TABLE_C
go
/******************************************************************************
	name		: dbo.KWP00305_SG_WS_EVENT_TABLE_C
	description	: 이벤트 참여자 관리 테이블 조건 추가
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-08-12	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_EVENT_TABLE_C
(	@pTableType		tinyint
,	@pTableName		varchar(50)
,	@pTableText		nvarchar(16)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vTableNo int = case @pTableType when 1 then 1000000 else 2000000 end
		,	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	-- 테이블이 이미 존재하는 경우 처리
	if exists (
		select	top 1 1
		from	dbo.KWT003_SG_WS_EVENT_TABLE
		where	table_name = @pTableName
	)
	begin
		set @oReturnNo = -2
		return
	end


	insert into dbo.KWT003_SG_WS_EVENT_TABLE
		(	table_no
		,	table_name
		,	event_name
		,	use_flag
		,	ipt_time
		)
	select	isnull(max(table_no),@vTableNo) + 1
		,	@pTableName
		,	@pTableText
		,	@pIsUsed
		,	getdate()
	from	dbo.KWT003_SG_WS_EVENT_TABLE
	where	table_no > @vTableNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00305_SG_WS_EVENT_TABLE_C
 @pTableName = ''
,@pTableText = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00305_SG_WS_EVENT_TABLE_C to [opwebuser]
go

