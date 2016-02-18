use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_ADMIN_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_ADMIN_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_ADMIN_INFO_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_ADMIN_INFO_U
	Description	: 관리 유저 변경
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: password error
					-3	: duplicate name
					-4	: UPDATE error
					-5	: delete error
					-6	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-07-03	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_ADMIN_INFO_U
(	@pAdminNo		int
,	@pAdminName		nvarchar(20)
,	@pPassword		char(32)
,	@pAuthGroup		int
,	@pDeptNo		int
,	@pIsUsed		bit
,	@pNoteText		nvarchar(30)
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if len(@pPassword) between 1 and 31
	begin
		set @oReturnNo = -2
		return
	end

	-- 중복 이름 체크
	if exists (
		select	1
		from	dbo.KWT001_SG_WS_MANGR_LIST with(nolock)
		where	cAdminName	= @pAdminName
			and	cAdminNo	!= @pAdminNo
	)
	begin
		set @oReturnNo = -3
		return
	end


	begin tran
		set @oReturnNo = -4
		-- 관리 유저 내용 변경
		update	a
		set		cAdminName	= @pAdminName
			,	cPassword	= case @pPassword when '' then cPassword else @pPassword end
			,	cDeptNo		= @pDeptNo
			,	cIsUsed		= @pIsUsed
			,	cNoteText	= @pNoteText
			,	cHostIp		= @pHostIp
			,	cModifyTime	= @vGetDate
		from	dbo.KWT001_SG_WS_MANGR_LIST as a
		where	cAdminNo	= @pAdminNo

		if @@rowcount = 0
		begin
			if @@trancount > 0 rollback tran
			return
		end


		set @oReturnNo = -5
		-- 기존 권한 삭제
		delete
		from	dbo.KWT001_SG_WS_MANGR_GROUP_MST
		where	cAdminNo = @pAdminNo

		if @@rowcount > 1
		begin
			if @@trancount > 0 rollback tran
			return
		end

		if @pAuthGroup = 0
		begin
			commit tran
			set @oReturnNo = 0
			return
		end


		set @oReturnNo = -6
		-- 권한 부여
		insert into dbo.KWT001_SG_WS_MANGR_GROUP_MST
			(	cAuthGroup
			,	cAdminNo
			,	cCreateTime
			)
		values
			(	@pAuthGroup
			,	@pAdminNo
			,	@vGetDate
			)

		if @@rowcount = 0
		begin
			if @@trancount > 0 rollback tran
			return
		end
	commit tran


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(20)
,@o2 varchar(120)
,@o3 int
,@o4 bit
,@o5 int
,@o6 varchar(100)
,@sp int
exec dbo.KWP00107_SG_WS_ADMIN_INFO_U
 @pMenuNo = 100100001
,@oMenuName = @o1 output
,@oMenuUrl = @o2 output
,@oMenuGroup = @o3 output
,@oIsUsed = @o4 output
,@oOrderBy = @o5 output
,@oNoteText = @o6 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @o5
print @o6
print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_ADMIN_INFO_U to [opwebuser]
go

