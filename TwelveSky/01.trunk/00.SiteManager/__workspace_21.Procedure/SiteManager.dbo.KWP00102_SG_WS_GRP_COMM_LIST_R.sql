use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_GRP_COMM_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_GRP_COMM_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_GRP_COMM_LIST_R
go
/******************************************************************************
	name		: KWP00102_SG_WS_GRP_COMM_LIST_R
	description	: 사이트 코드에 대한 그룹코드 리스트 반환
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_GRP_COMM_LIST_R
(	@pSiteGroup		smallint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cSiteGroup
		,	cCommGroup
		,	cCommName
		,	cNoteText
		,	cIsUsed
		,	cOrderBy
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
	where	cSiteGroup	= @pSiteGroup
--		and	cIsUsed	= 1
	order by cOrderBy


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @SP int
exec dbo.KWP00102_SG_WS_GRP_COMM_LIST_R
 @pSiteGroup = 10001
,@oReturnNo = @SP output

print @SP
*/
go

grant execute on dbo.KWP00102_SG_WS_GRP_COMM_LIST_R to [opwebuser]
go


