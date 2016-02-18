use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_ADMIN_PASSWD_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_ADMIN_PASSWD_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_ADMIN_PASSWD_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_ADMIN_PASSWD_U
	Description	: 관리자 비밀번호 수정
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: inValidate parameter error.[ @pAdminNo ]
					-3	: inValidate parameter error.[ @pPasswordOld ]
					-4	: inValidate parameter error.[ @pPasswordNew ]
					-5	: inValidate parameter error.[ @pPasswordOld = @pPasswordNew ]
					-7	: EXCUTE UPDATE-SQL( Record Update fail )

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-12	Hoon-Sik,Jin	1.CREATE
*******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_ADMIN_PASSWD_U
(	@pAdminNo		int				-- 관리자 번호
,	@pPasswordOld	char(32)		-- 관리자 패스워드
,	@pPasswordNew	char(32)		-- 새로운 패스워드
,	@pHostIp		varchar(15)		-- 수정한 IP
,	@oReturnNo		int 	output	-- 리턴값

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	--- Validate parameter error ---
	if len(@pAdminNo) < 5
	begin
		set @oReturnNo = -2
		return
	end

	if len(rtrim(@pPasswordOld)) < 30
	begin
		set @oReturnNo = -3
		return
	end

	if len(rtrim(@pPasswordNew)) < 30
	begin
		set @oReturnNo = -4
		return
	end

	if @pPasswordOld = @pPasswordNew
	begin
		set @oReturnNo = -5
		return
	end
	--- Validate parameter error ---


	update	a
	set		cPassword	= @pPasswordNew
		,	cHostIp		= @pHostIp
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
	where	cAdminNo	= @pAdminNo
		and	cPassword	= @pPasswordOld

	if @@rowcount != 1
	begin
		set @oReturnNo = -7
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @p1 int
,@p2 char(32)
,@p3 char(32)
,@sp int
exec dbo.KWP00107_SG_WS_ADMIN_PASSWD_U
 @pAdminNo = @p1
,@pPasswordOld = @p2
,@pPasswordNew = @p3
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_ADMIN_PASSWD_U to [opwebuser]
go

