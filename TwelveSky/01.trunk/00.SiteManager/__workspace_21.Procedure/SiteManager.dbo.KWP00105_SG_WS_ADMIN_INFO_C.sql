use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_ADMIN_INFO_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_ADMIN_INFO_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_ADMIN_INFO_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_ADMIN_INFO_C
	Description	: 관리 유저 추가
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: password error
					-3	: duplicate id
					-4	: duplicate name
					-5	: INSERT error
					-6	: SELECT error
					-7	: delete error
					-8	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-07-03	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_ADMIN_INFO_C
(	@pAdminId		varchar(20)
,	@pPassword		char(32)
,	@pAdminName		nvarchar(20)
,	@pAuthGroup		int
,	@pDeptNo		int
,	@pIsUsed		bit
,	@pNoteText		nvarchar(30)
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vAdminNo int
		,	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if len(@pPassword) < 32
	begin
		set @oReturnNo = -2
		return
	end

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_MANGR_LIST
		where	cAdminId = @pAdminId
	)
	begin
		set @oReturnNo = -3
		return
	end

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_MANGR_LIST
		where	cAdminName = @pAdminName
	)
	begin
		set @oReturnNo = -4
		return
	end


	begin tran
		select	@vAdminNo	= next value for dbo.sAdminNo
			,	@oReturnNo	= -5

		-- 새로운 메뉴로 등록
		insert into dbo.KWT001_SG_WS_MANGR_LIST
			(	cAdminNo
			,	cAdminId
			,	cPassword
			,	cAdminName
			,	cDeptNo
			,	cIsUsed
			,	cNoteText
			,	cHostIp
			,	cCreateTime
			)
		values
			(	@vAdminNo
			,	@pAdminId
			,	@pPassword
			,	@pAdminName
			,	@pDeptNo
			,	@pIsUsed
			,	@pNoteText
			,	@pHostIp
			,	@vGetDate
			)

		if @@rowcount = 0
		begin
			if @@trancount > 0 rollback tran
			return
		end


		set @oReturnNo = -6
		-- 기존 권한 삭제
		delete
		from	dbo.KWT001_SG_WS_MANGR_GROUP_MST
		where	cAdminNo = @vAdminNo

		if @@rowcount > 1
		begin
			if @@trancount > 0 rollback tran
			return
		end


		set @oReturnNo = -7
		-- 권한 부여
		insert into dbo.KWT001_SG_WS_MANGR_GROUP_MST
			(	cAuthGroup
			,	cAdminNo
			,	cCreateTime
			)
		values
			(	@pAuthGroup
			,	@vAdminNo
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
declare @rt int
exec dbo.KWP00105_SG_WS_ADMIN_INFO_C
 @pAdminId = 'likethis79'
,@pPassword = 'efb50b1cf32d8db47ff91573d64f1984'
,@pAdminName = N'진훈식'
,@pDeptGroup = 3001001
,@pIsUsed = 1
,@pNoteText = N'최고관리자 입니다!!'
,@pHostIp = '221.140.152.71'
,@oReturnNo = @rt output

print @rt
*/
go

grant execute on dbo.KWP00105_SG_WS_ADMIN_INFO_C to [opwebuser]
go

