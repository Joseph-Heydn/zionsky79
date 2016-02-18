use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_ADMIN_REGST_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_ADMIN_REGST_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_ADMIN_REGST_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_ADMIN_REGST_C
	Description	: 관리자 작업 로그 생성
	Reference	:
	return		: @o_return_no
					 0	: Success
					-1	: initialize error
					-2	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
	1.1		2014-07-03	Hong-Suk,Kim	1.관리자 이름 중복 검사 오류 수정
 ******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_ADMIN_REGST_C
(	@i_admin_nm		nvarchar(20)
,	@i_admin_id		varchar(20)
,	@i_admin_pw		varchar(32)
,	@i_dept_no		int
,	@i_note_desc	nvarchar(100)
,	@i_ip_addr		varchar(15)
,	@o_return_no	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@v_return_no int
	set @o_return_no = -1

	select	@v_return_no	= 1
	from	dbo.KWT001_SG_WS_MANGR_LIST
	where	admin_id		= @i_admin_id

	if @@rowcount > 0
	begin
		set @o_return_no = -2
		return
	end


	select	@v_return_no	= 1
	from	dbo.KWT001_SG_WS_MANGR_LIST
	where	admin_nm		= @i_admin_nm

	if @@rowcount > 0
	begin
		set @o_return_no = -3
		return
	end


	insert into dbo.KWT001_SG_WS_MANGR_LIST
		(	admin_no
		,	admin_id
		,	admin_pwd
		,	admin_nm
		,	dept_grp_no
		,	use_flag
		,	note_desc
		,	upt_addr
		,	ipt_time
		)
	select	max(admin_no) +1
		,	@i_admin_id
		,	@i_admin_pw
		,	@i_admin_nm
		,	@i_dept_no
		,	0
		,	@i_note_desc
		,	@i_ip_addr
		,	getdate()
	from	dbo.KWT001_SG_WS_MANGR_LIST

	if @@error != 0 and @@rowcount = 0
	begin
		set @o_return_no = -2
		return
	end


	set @o_return_no = 0
	set nocount off
end
/*
use SiteManager
declare
 @p1 int = 100000001
,@p2 int = 100000001
,@p3 char(1) = 'C'
,@p4 varchar(2000) = '로그인'
,@p5 varchar(255) = '/APP/SiteManager/mgrBaseCode_Main.aspx?txtMenuSel=0'
,@p6 varchar(15) = '10.181.192.42'
,@sp int
exec dbo.KWP00105_SG_WS_ADMIN_REGST_C
 @i_admin_no = @p1
,@i_menu_no = @p2
,@i_log_cd = @p3
,@i_note_desc = @p4
,@i_http_url = @p5
,@i_ip_addr = @p6
,@o_return_no = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_ADMIN_REGST_C to [opwebuser]
go

