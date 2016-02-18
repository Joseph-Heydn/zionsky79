use SiteManager
go
if object_id('dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R') is null
	exec('create procedure dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R as select 1')
--	drop procedure dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R
go
/******************************************************************************
	name		: KWP00302_SG_WS_GAME_TABLE_LIST_R
	description	: 관리 테이블 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R
(	@pGameNo		int
,	@pDatabase		varchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	cTableNo
		,	cDatabase
		,	cTableId
		,	cTableName
		,	cTableText
		,	cIsUsed
	from	dbo.KWT003_SG_WS_GAME_TABLE
	where	cGameNo		= @pGameNo
		and	(	cDatabase	= @pDatabase
			or	@pDatabase	= ''
			)


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R
 @pGameNo = 20150001
,@pDatabase = ''
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R to [opwebuser]
go

