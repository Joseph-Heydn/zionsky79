use SiteManager
go
if object_id('dbo.KWP00103_SG_WS_ADMIN_LOGIN_R') is null
	exec ('create procedure dbo.KWP00103_SG_WS_ADMIN_LOGIN_R as select 1')
--	drop procedure dbo.KWP00103_SG_WS_ADMIN_LOGIN_R
go
/******************************************************************************
	Name		: dbo.KWP00103_SG_WS_ADMIN_LOGIN_R
	Description	: 관리자 로그인
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 사용자 정보 불일치
					-3	: 접속 로그 생성실패
					-4	: 로그인 정보 불일치

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00103_SG_WS_ADMIN_LOGIN_R
(	@pAdminId		varchar(20)
,	@pPassword		char(64)
,	@oAdminNo		int				output
,	@oAdminName		nvarchar(20)	output
,	@oAuthGroup		int				output
,	@oDeptNo		int				output
,	@oConnTime		datetime		output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare @vPassword binary(70)
	set @oReturnNo = -1

	--입력값 검증
	if len(@pAdminId) < 10 or len(@pPassword) < 60
	begin
		set @oReturnNo = -2
		return
	end


	select	@oAdminNo	= a.cAdminNo
		,	@oAdminName	= a.cAdminName
		,	@vPassword	= a.cPassword
		,	@oDeptNo	= a.cDeptNo
		,	@oAuthGroup	= b.cAuthGroup
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
			inner join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as b
		on	b.cAdminNo	= a.cAdminNo
	where	a.cAdminId	= @pAdminId
		and	a.cIsUsed	= 1

	if @@rowcount = 0
	begin
		set @oReturnNo = -3
		return -3
	end

	if pwdcompare(@pPassword, @vPassword) = 0
	begin
		set @oReturnNo = -4
		return -4
	end


	update	a
	set		@oConnTime	= cLoginTime = getdate()
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
	where	cAdminId	= @pAdminId
		and	cPassword	= @pPassword

	if @@error != 0
	begin
		set @oReturnNo = -3
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @p3 int
,@p4 varchar(20)
,@p5 int
,@p6 int
,@p7 datetime
,@sp int
exec dbo.KWP00103_SG_WS_ADMIN_LOGIN_R
 @pAdminId = 'msu0308'
,@pPassword = '23bded6516f0fde8fa6c057983e2a1c7'
,@oAdminNo = @p3 output
,@oAdminName = @p4 output
,@oAuthGroup = @p5 output
,@oDeptNo = @p6 output
,@oConnTime = @p7 output
,@oReturnNo = @sp output

print @p3
print @p4
print @p5
print @p6
print @p7
print @sp
*/
go

grant execute on dbo.KWP00103_SG_WS_ADMIN_LOGIN_R to [opwebuser]
go

