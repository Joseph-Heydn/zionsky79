use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_ADMIN_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_ADMIN_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_ADMIN_LIST_R
go
/******************************************************************************
	Name		: dbo.KWP00102_SG_WS_ADMIN_LIST_R
	Description	: 관리자 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_ADMIN_LIST_R
(	@pAuthGroup		int
,	@pCommGroup		int
,	@pAdminNo		int
,	@pFilterNo		tinyint
,	@pFilterText	nvarchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vAutherNo	int
		,	@vOrderBy	int
	set @oReturnNo = -1

	select	@vOrderBy		= b.cOrderBy
	from	dbo.KWT001_SG_WS_MANGR_GROUP_MST as a
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST	as b
		on	b.cCommGroup	= a.cAuthGroup
		and	b.cSiteGroup	= 2001
	where	a.cAdminNo		= @pAdminNo

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	if @pCommGroup = 0 and @pFilterText = ''
	begin
		select	a.cAdminNo
			,	a.cAdminId
			,	a.cAdminName
			,	a.cDeptNo
			,	c.cAuthGroup
			,	b.cCommName as cDeptName
			,	d.cCommName as cAuthName
			,	d.cOrderBy
			,	a.cIsUsed
			,	a.cNoteText
		from	dbo.KWT001_SG_WS_MANGR_LIST as a
				inner join
				dbo.KWT001_SG_WS_COMM_GROUP_MST as b
			on	b.cCommGroup	= a.cDeptNo
				inner join
				dbo.KWT001_SG_WS_MANGR_GROUP_MST as c
			on	c.cAdminNo		= a.cAdminNo
				inner join
				dbo.KWT001_SG_WS_COMM_GROUP_MST as d
			on	d.cCommGroup	= c.cAuthGroup
		where	(	c.cAuthGroup	= @pAuthGroup
				or	@pAuthGroup		= 0
				)
			and	(	d.cOrderBy		>= @vOrderBy
				or	d.cOrderBy		is null
				)
		union all
		select	a.cAdminNo
			,	a.cAdminId
			,	a.cAdminName
			,	0
			,	0
			,	''
			,	''
			,	-1
			,	a.cIsUsed
			,	a.cNoteText
		from	dbo.KWT001_SG_WS_MANGR_LIST as a
				left outer join
				dbo.KWT001_SG_WS_MANGR_GROUP_MST as b
			on	b.cAdminNo	= a.cAdminNo
		where	b.cAdminNo	is null


		set @oReturnNo = 0
		return
	end


	select	a.cAdminNo
		,	a.cAdminId
		,	a.cAdminName
		,	a.cDeptNo
		,	c.cAuthGroup
		,	b.cCommName as cDeptName
		,	d.cCommName as cAuthName
		,	d.cOrderBy
		,	a.cIsUsed
		,	a.cNoteText
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST	as b
		on	b.cCommGroup	= a.cDeptNo
		and	b.cSiteGroup	= 3001
			inner join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as c
		on	c.cAdminNo		= a.cAdminNo
		and	c.cAuthGroup	> 0
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST	as d
		on	d.cCommGroup	= c.cAuthGroup
	where	(	d.cOrderBy	>= @vOrderBy
			or	d.cOrderBy	is null
			)
		and	a.cAdminName	> ''
		and	a.cAdminNo		> 0
		and	(	d.cCommGroup	= @pCommGroup
			or	@pCommGroup		= 0
			)
		and	(	c.cAuthGroup	= @pAuthGroup
			or	@pAuthGroup		= 0
			)
		and	a.cAdminNo		= case @pFilterNo when 3 then convert(int,@pFilterText) else a.cAdminNo end
		and	a.cAdminId		= case @pFilterNo when 2 then @pFilterText else a.cAdminId end
		and	a.cAdminName	= case @pFilterNo when 1 then @pFilterText else a.cAdminName end


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_ADMIN_LIST_R
 @pAuthGroup = 0
,@pCommGroup = 0
,@pAdminNo = 100000001
,@pFilterNo = 1
,@pFilterText = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00102_SG_WS_ADMIN_LIST_R to [opwebuser]
go

