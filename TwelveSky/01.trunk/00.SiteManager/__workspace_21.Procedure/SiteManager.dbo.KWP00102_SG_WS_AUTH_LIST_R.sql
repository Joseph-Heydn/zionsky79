use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_AUTH_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_AUTH_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_AUTH_LIST_R
go
/******************************************************************************
	name		: KWP00102_SG_WS_AUTH_LIST_R
	description	: 관리자 검색 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_AUTH_LIST_R
(	@pAdminNo		int
,	@pAdminId		varchar(20)
,	@pAdminName		nvarchar(20)
,	@pGroupNo		int
,	@oRowCnt		int		output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	a.cAdminNo
		,	a.cAdminId
		,	a.cAdminName
		,	a.cDeptNo
		,	a.cNoteText
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
			inner join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as b
		on	b.cAdminNo		= a.cAdminNo
	where	(a.cAdminNo		= @pAdminNo		or @pAdminNo = 0)
		and	(	a.cAdminName	> N''
			and	(a.cAdminId	= @pAdminId		or	@pAdminId = '')
			)
		and	(a.cAdminName	= @pAdminName	or @pAdminName = N'')
		and	(b.cAuthGroup	= @pGroupNo		or @pGroupNo = 0)
	order by a.cAdminName

	set @oRowCnt = @@rowcount


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare
 @P1 int
,@SP int
exec dbo.KWP00102_SG_WS_AUTH_LIST_R
 @pAdminNo = 0
,@pAdminId = 'likethis79'
,@pAdminName = ''
,@pGroupNo = ''
,@oRowCnt = @P1 output
,@oReturnNo = @SP output

print @P1
*/
go

grant execute on dbo.KWP00102_SG_WS_AUTH_LIST_R to [opwebuser]
go

