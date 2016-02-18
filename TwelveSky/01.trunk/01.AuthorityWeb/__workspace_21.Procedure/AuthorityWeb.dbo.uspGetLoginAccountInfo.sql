use AuthorityWeb
go
if object_id('dbo.uspGetLoginAccountInfo') is null
	exec ('create procedure dbo.uspGetLoginAccountInfo as select 1')
--	drop procedure dbo.uspGetLoginAccountInfo
go
/******************************************************************************
	Name		: dbo.uspGetLoginAccountInfo
	Description	: 로그인
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLoginAccountInfo
(	@pAccountId		varchar(50)
,	@pPassword		char(32)
,	@oPublisher		tinyint			output
,	@oAccountNo		bigint			output
,	@oBlockType		tinyint			output
,	@oNickName		nvarchar(20)	output
,	@oEmail			varchar(50)		output
,	@oStatus		tinyint			output
,	@oIsCertify		bit				output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vStatus	tinyint
		,	@vPassword	binary(70)
	select	@oPublisher	= 0
		,	@oAccountNo	= 0
		,	@oBlockType	= 0
		,	@oIsCertify	= 0
		,	@oStatus	= 0
		,	@oNickName	= ''
		,	@oEmail		= ''

	select	@oAccountNo	= cAccountNo
		,	@vPassword	= cPassword
		,	@vStatus	= cStatus
	from	dbo.tAccountInfo
	where	cAccountId	= @pAccountId

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end

	if @vStatus != 1
	begin
		set @oReturnNo = 2
		return 2
	end

	if pwdcompare(@pPassword, @vPassword) = 0
	begin
		set @oReturnNo = 3
		return 3
	end


	select	top 1
			@oBlockType	= cBlockType
	from	dbo.tBlockHistory
	where	cAccountNo	= @oAccountNo
		and	cLimitTime	> getdate()
	order by cBolckNo desc

	if @@rowcount > 0
	begin
		set @oReturnNo = 4
		return 4
	end


	update	a
	set		@oNickName		= cNickName
		,	@oEmail			= cEmail
		,	@oIsCertify		= case when cCertfyTime is null then 0 else 1 end
		,	@oStatus		= cStatus
		,	@oPublisher		= cPublisher
		,	cLoginTime		= getdate()
	from	dbo.tAccountInfo as a
	where	cAccountNo		= @oAccountNo


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @o1 tinyint
,@o2 bigint
,@o3 tinyint
,@o4 nvarchar(16)
,@o5 varchar(50)
,@o6 tinyint
,@o7 bit
,@sp int
,@rt int
exec @sp = dbo.uspGetLoginAccountInfo
 @pAccountId = 'jhwan85'
,@pPassword = '0724asas'
,@oPublisher = @o1 out
,@oAccountNo = @o2 out
,@oBlockType = @o3 out
,@oNickName = @o4 out
,@oEmail = @o5 out
,@oStatus = @o6 out
,@oIsCertify = @o7 out
,@oReturnNo = @rt out

print  '@oPublisher		: '+ rtrim(@o1)
print  '@oAccountNo		: '+ rtrim(@o2)
print  '@oBlockType		: '+ rtrim(@o3)
print  '@oNickName		: '+ rtrim(@o4)
print  '@oEmail			: '+ rtrim(@o5)
print  '@oStatus		: '+ rtrim(@o6)
print  '@oIsCertify		: '+ rtrim(@o7)
print  '@vReturnNo		: '+ rtrim(@sp)
print  '@oReturnNo		: '+ rtrim(@rt)
*/
go

grant execute on dbo.uspGetLoginAccountInfo to [sawebuser]
go

