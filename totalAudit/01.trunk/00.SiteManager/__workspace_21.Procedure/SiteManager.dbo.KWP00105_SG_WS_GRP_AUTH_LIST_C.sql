use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_USER_AUTH_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_USER_AUTH_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_USER_AUTH_C
go
/******************************************************************************
	name		: KWP00105_SG_WS_GRP_USER_AUTH_C
	description	: 관리자 메뉴 권한 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_USER_AUTH_C
(	@pAuthGroup		int
,	@pAdminList		varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_MANGR_GROUP_MST
		(	cAuthGroup
		,	cAdminNo
		,	cCreateTime
		)
	select	@pAuthGroup
		,	a.cValue
		,	@vGetDate
	from	dbo.fnTbl2Int(@pAdminList,'|')	as a
			left outer join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST	as b with(nolock)
		on	b.cAdminNo		= a.cValue
		and	b.cAuthGroup	= @pAuthGroup
	where	b.cAdminNo		is null

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00105_SG_WS_GRP_USER_AUTH_C
 @pAuthGroup = 100200003
,@pAdminList = '|'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_GRP_USER_AUTH_C to [opwebuser]
go

