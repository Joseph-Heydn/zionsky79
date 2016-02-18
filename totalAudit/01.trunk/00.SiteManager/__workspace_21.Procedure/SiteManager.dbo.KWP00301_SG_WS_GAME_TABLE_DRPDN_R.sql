use SiteManager
go
if object_id('dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R') is null
	exec('create procedure dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R as select 1')
--	drop procedure dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R
go
/******************************************************************************
	name		: KWP00301_SG_WS_GAME_TABLE_DRPDN_R
	description	: 관리 테이블 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R
(	@pGameNo		int
,	@pDatabase		varchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	cTableNo
		,	cTableName
		,	cTableText
	from	dbo.KWT003_SG_WS_GAME_TABLE
	where	cGameNo		= @pGameNo
		and	cDatabase	= @pDatabase


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R
 @pTableType = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R to [opwebuser]
go

