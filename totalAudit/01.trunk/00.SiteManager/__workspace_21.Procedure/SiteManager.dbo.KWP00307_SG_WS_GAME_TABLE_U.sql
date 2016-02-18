use SiteManager
go
if object_id('dbo.KWP00307_SG_WS_GAME_TABLE_U') is null
	exec('create procedure dbo.KWP00307_SG_WS_GAME_TABLE_U as select 1')
--	drop procedure dbo.KWP00307_SG_WS_GAME_TABLE_U
go
/******************************************************************************
	name		: KWP00307_SG_WS_GAME_TABLE_U
	description	: 관리 테이블 설명 수정
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-08-13	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00307_SG_WS_GAME_TABLE_U
(	@pTableNo		int
,	@pTableText		nvarchar(16)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	update	a
	set		cTableText	= @pTableText
		,	cIsUsed		= @pIsUsed
	from	dbo.KWT003_SG_WS_GAME_TABLE as a
	where	cTableNo	= @pTableNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00307_SG_WS_GAME_TABLE_U
 @pTableNo = 1000001
,@pTableText = ''
,@pIsUsed = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00307_SG_WS_GAME_TABLE_U to [opwebuser]
go

