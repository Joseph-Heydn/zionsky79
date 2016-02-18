use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_GAME_TABLE_C') is null
	exec('create procedure dbo.KWP00305_SG_WS_GAME_TABLE_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_GAME_TABLE_C
go
/******************************************************************************
	name		: dbo.KWP00305_SG_WS_GAME_TABLE_C
	description	: 관리 테이블 추가
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_GAME_TABLE_C
(	@pGameNo		int
,	@pDatabase		varchar(20)
,	@pTableId		int
,	@pTableName		varchar(50)
,	@pTableText		nvarchar(16)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set transaction isolation level read uncommitted

	declare @vGetDate datetime = getdate()
	set @oReturnNo = -1

	if @pTableId = 0 or len(@pDatabase) < 1 or @pGameNo < 20150000
	begin
		set @oReturnNo = -2
		return
	end

	-- 테이블이 이미 존재하는 경우 처리
	if exists (
		select	1
		from	dbo.KWT003_SG_WS_GAME_TABLE
		where	cGameNo		= @pGameNo
			and	cDatabase	= @pDatabase
			and	cTableId	= @pTableId
	)
	begin
		set @oReturnNo = -3
		return
	end


	set @oReturnNo = 4
	insert into dbo.KWT003_SG_WS_GAME_TABLE
		(	cTableNo
		,	cGameNo
		,	cDatabase
		,	cTableId
		,	cTableName
		,	cTableText
		,	cIsUsed
		,	cCreateTime
		)
	values
		(	next value for dbo.sTableNo
		,	@pGameNo
		,	@pDatabase
		,	@pTableId
		,	@pTableName
		,	@pTableText
		,	@pIsUsed
		,	@vGetDate
		)


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00305_SG_WS_GAME_TABLE_C
 @pGameNo = 20150001
,@pDatabase = ''
,@pTableId = 1
,@pTableName = ''
,@pTableText = N''
,@pIsUsed = 1
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.KWP00305_SG_WS_GAME_TABLE_C to [opwebuser]
go

