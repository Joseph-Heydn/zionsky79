use ondmdAudit
go
if object_id('dbo.uspGetDashBoard') is null
	exec ('create procedure dbo.uspGetDashBoard as select 1')
--	drop procedure dbo.uspGetDashBoard
go
/******************************************************************************
	Name		: dbo.uspGetDashBoard
	Description	: 메인화면 대시보드
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2016-02-17	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetDashBoard
(	@pInstence	nvarchar(800)
,	@pStartDay	datetime
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -99

	-- 최근 7일간 기록
	exec aud.uspGraphServerAction7
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDataBaseAction7
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDDLAction7			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDMLAction7
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay


	-- 최근 24시간 기록
	exec aud.uspGraphServerAction24
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDataBaseAction24
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDDLAction24
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDMLAction24
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay


	-- TOP 5 기록
	exec aud.uspGraphServerActions_Top5
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDatabaseActions_Top5
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDDLActions_Top5
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay

	exec aud.uspGraphDMLActions_Top5
			@instance_name	= @pInstence
		,	@searchdate		= @pStartDay


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use ondmdAudit
declare
 @sp int
,@rt int
exec dbo.uspGetDashBoard
 @pInstence = 'FUTURE-PC'
,@pStartDay = '2016-01-27'
,@oReturnNo = @rt out

print @sp
print @rt

exec aud.uspListServerInstanceNameforMenu
exec aud.uspListClassTypeforMenu
exec aud.uspListActionNameforMenu
exec aud.uspListDatabaseNameforMenu
@instance_name = 'FUTURE-PC'
*/
go

grant execute on dbo.uspGetDashBoard to [sawebuser]
go

