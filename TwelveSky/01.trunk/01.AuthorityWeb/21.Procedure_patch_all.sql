use AuthorityWeb
go
if object_id('dbo.uspFindObject') is null
	exec ('create procedure dbo.uspFindObject as select 1')
--	drop procedure dbo.uspFindObject
go
/******************************************************************************
	Name		: dbo.uspFindObject
	Description	: 프로시저에서 개체 검색
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-05	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspFindObject
(	@pObjName	sysname

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	object_name(id) as cObjName
		,	count(*) as cRowCnt
	from	syscomments
	where	[text] like '%'+ @pObjName +'%'
	group by id
	order by cObjName


	set nocount off
end
/*
set statistics io on
use AuthorityWeb
exec @sp = dbo.uspFindObject
@pObjName = ''
*/
go

use AuthorityWeb
go
if object_id('dbo.uspGetAccountDetailInfo') is null
	exec ('create procedure dbo.uspGetAccountDetailInfo as select 1')
--	drop procedure dbo.uspGetAccountDetailInfo
go
/******************************************************************************
	Name		: dbo.uspGetAccountDetailInfo
	Description	: api - 토큰으로 유저정보 찾기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetAccountDetailInfo
(	@pToken			uniqueidentifier
,	@oSecret		char(27)		output
,	@oPublisher		tinyint			output
,	@oAccountNo		bigint			output
,	@oAccountId		varchar(50)		output
,	@oNickName		nvarchar(20)	output
,	@oEmail			varchar(50)		output
,	@oEmailCert		bit				output
,	@oStatus		tinyint			output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oSecret		= ''
		,	@oAccountId		= ''
		,	@oNickName		= ''
		,	@oEmail			= ''
		,	@oAccountNo		= 0
		,	@oEmailCert		= 0
		,	@oStatus		= 0
		,	@oReturnNo		= -1

	select	@oSecret		= a.cSecret
		,	@oPublisher		= b.cPublisher
		,	@oAccountNo		= b.cAccountNo
		,	@oAccountId		= b.cAccountId
		,	@oNickName		= b.cNickName
		,	@oEmail			= b.cEmail
		,	@oEmailCert		= case when b.cCertfyTime is null then 0 else 1 end
		,	@oStatus		= b.cStatus
	from	dbo.tGuestConsumer as a
			inner join
			dbo.tAccountInfo as b
		on	b.cAccountNo	= a.cAccountNo
	where	a.cToken		= @pToken

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @o1 char(27)
,@o2 tinyint
,@o3 bigint
,@o4 varchar(20)
,@o5 nvarchar(16)
,@o6 varchar(50)
,@o7 bit
,@o8 tinyint
,@sp int
,@rt int
exec @sp = dbo.uspGetAccountDetailInfo
 @pToken = '720658F7-8E9F-4F1F-900C-B45DD6F1AF7D'
,@oSecret = @o1 out
,@oPublisher = @o2 out
,@oAccountNo = @o3 out
,@oAccountId = @o4 out
,@oNickName = @o5 out
,@oEmail = @o6 out
,@oEmailCert = @o7 out
,@oStatus = @o8 out
,@oReturnNo = @rt out

print  '@oSecret	: '+ rtrim(@o1)
print  '@oPublisher	: '+ rtrim(@o2)
print  '@oAccountNo	: '+ rtrim(@o3)
print  '@oAccountId	: '+ rtrim(@o4)
print  '@oNickName	: '+ rtrim(@o5)
print  '@oEmail		: '+ rtrim(@o6)
print  '@oEmailCert	: '+ rtrim(@o7)
print  '@oStatus	: '+ rtrim(@o8)
print  '@vReturnNo	: '+ rtrim(@sp)
print  '@oReturnNo	: '+ rtrim(@rt)
*/
go

grant execute on dbo.uspGetAccountDetailInfo to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetAccountInfo') is null
	exec ('create procedure dbo.uspGetAccountInfo as select 1')
--	drop procedure dbo.uspGetAccountInfo
go
/******************************************************************************
	Name		: dbo.uspGetAccountInfo
	Description	: 유저 상세 정보
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetAccountInfo
(	@pAccountNo		bigint
,	@oNickName		nvarchar(20)	output
,	@oExts			char(3)			output
,	@oBirthDay		smalldatetime	output
,	@oIsEmail		bit				output
,	@oIsPhoto		bit				output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oNickName	= ''
		,	@oBirthDay	= 0
		,	@oIsEmail	= 0
		,	@oIsPhoto	= 0
		,	@oReturnNo	= -1

	select	@oNickName	= cNickName
		,	@oExts		= isnull(cExts,'')
		,	@oBirthDay	= isnull(cBirthDay,0)
		,	@oIsEmail	= cIsEmail
		,	@oIsPhoto	= cIsPhoto
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @o1 nvarchar(20)
,@o2 char(3)
,@o3 smalldatetime
,@o4 bit
,@o5 bit
,@rt int
,@sp int
exec @sp = dbo.uspGetAccountInfo
 @pAccountNo = 100019650
,@oNickName = @o1 out
,@oExts = @o2 out
,@oBirthDay = @o3 out
,@oIsEmail = @o4 out
,@oIsPhoto = @o5 out
,@oReturnNo = @rt out

print  '@oNickName	: '+ isnull(rtrim(@o1),'')
print  '@oExts		: '+ isnull(rtrim(@o2),'')
print  '@oBirthDay	: '+ isnull(convert(char(13),@o3,121),0)
print  '@oIsEmail	: '+ isnull(rtrim(@o4),0)
print  '@oIsPhoto	: '+ isnull(rtrim(@o5),0)
print  '@vReturnNo	: '+ rtrim(@rt)
print  '@oReturnNo	: '+ rtrim(@sp)
*/
go

grant execute on dbo.uspGetAccountInfo to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetCheckDupAccountId') is null
	exec ('create procedure dbo.uspGetCheckDupAccountId as select 1')
--	drop procedure dbo.uspGetCheckDupAccountId
go
/******************************************************************************
	Name		: dbo.uspGetCheckDupAccountId
	Description	: 중복 아이디 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCheckDupAccountId
(	@pAccountId		varchar(50)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if exists ( select 1 from dbo.tAccountInfo where cAccountId = @pAccountId )
	begin
		-- 이미 존재함
		set @oReturnNo = 1
		return 1
	end


	-- 사용 가능
	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetCheckDupAccountId to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetCheckDupEmail') is null
	exec ('create procedure dbo.uspGetCheckDupEmail as select 1')
--	drop procedure dbo.uspGetCheckDupEmail
go
/******************************************************************************
	Name		: dbo.uspGetCheckDupEmail
	Description	: 중복 이메일 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCheckDupEmail
(	@pAccountNo		bigint
,	@pEmail			varchar(50)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if exists ( select 1 from dbo.tAccountInfo where cAccountNo != @pAccountNo and cEmail = @pEmail and cDeleteTime is null )
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @sp int
,@rt int
exec @sp = dbo.uspGetCheckDupEmail
 @pAccountNo = 100000001
,@pEmail = 'mission2hs@daum.net'
,@oReturnNo = @rt out

print @sp
print @rt
*/
go

grant execute on dbo.uspGetCheckDupEmail to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetCheckDupNickName') is null
	exec ('create procedure dbo.uspGetCheckDupNickName as select 1')
--	drop procedure dbo.uspGetCheckDupNickName
go
/******************************************************************************
	Name		: dbo.uspGetCheckDupNickName
	Description	: 중복 닉네임 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCheckDupNickName
(	@pNickName		nvarchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if exists ( select 1 from dbo.tAccountInfo where cNickName = @pNickName )
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetCheckDupNickName to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetCheckEmailCertKey') is null
	exec ('create procedure dbo.uspGetCheckEmailCertKey as select 1')
--	drop procedure dbo.uspGetCheckEmailCertKey
go
/******************************************************************************
	Name		: dbo.uspGetCheckEmailCertKey
	Description	: 이메일 인증 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCheckEmailCertKey
(	@pCertKey		char(36)
,	@oCertNo		bigint		output
,	@oRequestNo		tinyint		output	-- 0: 아이디찾기, 1: 비밀번호찾기, 2: 유저 이메일인증
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vAccountNo	bigint
		,	@vStartTime	datetime
	select	@oRequestNo	= 0
		,	@oReturnNo	= 0

	select	top 1
			@oCertNo	= cCertNo
		,	@oRequestNo	= cRequestNo
		,	@vStartTime	= cCreateTime
	from	dbo.tEmailCert
	where	cCertKey	= @pCertKey
	order by cCertNo desc

	-- 1.발송된 인증키가 존재하지 않습니다.
	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end

	-- 20분 초과 하면 재인증해야 함.
	if dateadd(minute,20,@vStartTime) < getdate()
	begin
		set @oReturnNo = 2
		return 2
	end


	-- 유저 이메일 인증
	if @oRequestNo = 2
	begin
		begin try
			begin tran
				set @oReturnNo = 3
				update	a
				set		@vAccountNo		= cAccountNo
					,	cFinishTime		= getdate()
				from	dbo.tEmailCert as a
				where	cCertNo			= @oCertNo

				set @oReturnNo = 4
				update	a
				set		cCertfyTime		= getdate()
				from	dbo.tAccountInfo as a
				where	cAccountNo		= @vAccountNo
			commit tran
		end try

		begin catch
			if @@trancount > 0 rollback tran

			exec dbo.uspSetNewErrorLog
					@pPrintMsg	= 0
				,	@oErrorNo	= 0

			return @oReturnNo
		end catch
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetCheckEmailCertKey to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetConsumerInfo') is null
	exec ('create procedure dbo.uspGetConsumerInfo as select 1')
--	drop procedure dbo.uspGetConsumerInfo
go
/******************************************************************************
	Name		: dbo.uspGetConsumerInfo
	Description	: api - 컨슈머 정보
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetConsumerInfo
(	@pConsumerKey	char(10)
,	@oGameNo		int				output
,	@oSecret		char(15)		output
,	@oCallBack		varchar(100)	output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oGameNo	= 0
		,	@oCallBack	= ''
		,	@oSecret	= 0
		,	@oReturnNo	= -1

	select	@oGameNo		= cGameNo
		,	@oSecret		= cSecret
		,	@oCallBack		= isnull(cCallBackURL,'')
	from	dbo.tConsumerInfo
	where	cConsumerKey	= @pConsumerKey
		and cStatus			= 1

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetConsumerInfo to [sawebuser]
go

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

use AuthorityWeb
go
if object_id('dbo.uspGetLookupAccountId') is null
	exec ('create procedure dbo.uspGetLookupAccountId as select 1')
--	drop procedure dbo.uspGetLookupAccountId
go
/******************************************************************************
	Name		: dbo.uspGetLookupAccountId
	Description	: 이메일/아이디로 기본 정보 찾기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupAccountId
(	@pNickName		nvarchar(20)
,	@pAccountId		varchar(50)
,	@pPassword		char(32)
,	@pLookupType	tinyint
,	@oSecEmail		varchar(50)	output
,	@oAccountId		varchar(50)	output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oSecEmail	= ''
		,	@oAccountId	= ''
		,	@oReturnNo	= -1

	-- 아이디 찾기
	if @pLookupType = 0
	begin
		select	top 1
				@oAccountId	= cAccountId
			,	@oSecEmail	= cEmail
		from	dbo.tAccountInfo
		where	cNickName	= @pNickName
			and	cDeleteTime	is null
	end
	-- 인증메일 확인
	else if @pLookupType = 1
	begin
		update	a
		set		@oSecEmail	= cEmail
			,	cPassword	= pwdencrypt(@pPassword)
		from	dbo.tAccountInfo
		where	cAccountId	= @pAccountId
			and	cDeleteTime	is null
	end

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @o1 varchar(50)
,@o2 varchar(20)
,@rt int
exec dbo.uspGetLookupAccountId
 @pNickName = N'zionsky79'
,@pAccountId = 'likethis79@daum.net'
,@pPassword = ''
,@pLookupType = 1
,@oSecEmail = @o1 out
,@oAccountId = @o2 out
,@oReturnNo = @rt out

print @o1
print @o2
print @rt
*/
go

grant execute on dbo.uspGetLookupAccountId to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetLookupAccountNo') is null
	exec ('create procedure dbo.uspGetLookupAccountNo as select 1')
--	drop procedure dbo.uspGetLookupAccountNo
go
/******************************************************************************
	Name		: dbo.uspGetLookupAccountNo
	Description	: api - 회원번호 찾기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupAccountNo
(	@pToken			uniqueidentifier
,	@oAccountNo		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oAccountNo	= cAccountNo
	from	dbo.tGuestConsumer
	where	cToken		= @pToken

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetLookupAccountNo to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetLookupEmailCert') is null
	exec ('create procedure dbo.uspGetLookupEmailCert as select 1')
--	drop procedure dbo.uspGetLookupEmailCert
go
/******************************************************************************
	Name		: dbo.uspGetLookupEmailCert
	Description	: 인증 확인
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupEmailCert
(	@pAccountNo		bigint
,	@oEmailCert		tinyint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oEmailCert	= case when cCertfyTime is null then 0 else 1 end
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetLookupEmailCert to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetLookupGameNick') is null
	exec ('create procedure dbo.uspGetLookupGameNick as select 1')
--	drop procedure dbo.uspGetLookupGameNick
go
/******************************************************************************
	Name		: dbo.uspGetLookupGameNick
	Description	: 닉네임 찾기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupGameNick
(	@pAccountNo		bigint
,	@oGameNick		nvarchar(20)	output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oGameNick	= cGameNick
	from	dbo.tGuestConsumer
	where	cAccountNo	= @pAccountNo

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetLookupGameNick to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspGetLookupTokenSecret') is null
	exec ('create procedure dbo.uspGetLookupTokenSecret as select 1')
--	drop procedure dbo.uspGetLookupTokenSecret
go
/******************************************************************************
	Name		: dbo.uspGetLookupTokenSecret
	Description	: api - TokenSecret 찾기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupTokenSecret
(	@pToken			uniqueidentifier
,	@oSecret		char(27)	output
,	@oAccountNo		bigint		output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oSecret	= cSecret
		,	@oAccountNo	= cAccountNo
	from	dbo.tGuestConsumer
	where	cToken		= @pToken

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetLookupTokenSecret to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetFixAccountDetail') is null
	exec ('create procedure dbo.uspSetFixAccountDetail as select 1')
--	drop procedure dbo.uspSetFixAccountDetail
go
/******************************************************************************
	Name		: dbo.uspSetFixAccountDetail
	Description	: api - 게임 데이터 저장
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixAccountDetail
(	@pConsumerKey	char(10)
,	@pAccountNo		bigint
,	@pPlayerNo		bigint
,	@pGameNick		nvarchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare @vGameNo	int
		,	@vErrorMsg	nvarchar(max)
	set @oReturnNo = -1

	select	@vGameNo		= cGameNo
	from	dbo.tConsumerInfo
	where	cConsumerKey	= @pConsumerKey

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	begin try
		begin tran
			set @oReturnNo = 2
			update	a
			set		cPlayerNo		= @pPlayerNo
				,	cGameNick		= @pGameNick
			from	dbo.tGuestConsumer as a
			where	cGameNo			= @vGameNo
				and cAccountNo		= @pAccountNo
				and (	cPlayerNo	is null
					or	cPlayerNo	= @pPlayerNo
					)

			if @@rowcount != 1
			begin
				select	@oReturnNo = -2
					,	@vErrorMsg = '@pConsumerKey = '+ rtrim(@pConsumerKey)
					,	@vErrorMsg += ', @vGameNo = '+ rtrim(@vGameNo)
					,	@vErrorMsg += ', @pAccountNo = '+ rtrim(@pAccountNo)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetFixAccountDetail to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetFixAccountInfo') is null
	exec ('create procedure dbo.uspSetFixAccountInfo as select 1')
--	drop procedure dbo.uspSetFixAccountInfo
go
/******************************************************************************
	Name		: dbo.uspSetFixAccountInfo
	Description	: 회원정보 변경
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixAccountInfo
(	@pAccountNo		bigint
,	@pNickName		nvarchar(20)
,	@pExts			char(3)
,	@pBirthDay		smalldatetime
,	@pIsEmail		bit
,	@pIsPhoto		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	begin try
		set @oReturnNo = 1
		update	a
		set		cNickName		= @pNickName
			,	cExts			= case @pIsPhoto when 0 then null else @pExts end
			,	cBirthDay		= @pBirthDay
			,	cIsEmail		= @pIsEmail
			,	cIsPhoto		= @pIsPhoto
			,	cModifyTime		= getdate()
		from	dbo.tAccountInfo as a
		where	cAccountNo		= @pAccountNo
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetFixAccountInfo to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetFixCheckEmailCertKey') is null
	exec ('create procedure dbo.uspSetFixCheckEmailCertKey as select 1')
--	drop procedure dbo.uspSetFixCheckEmailCertKey
go
/******************************************************************************
	Name		: dbo.uspSetFixCheckEmailCertKey
	Description	: 이메일 인증 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixCheckEmailCertKey
(	@pCertNo		bigint
,	@oAccountNo		bigint		output
,	@oAccountId		varchar(50)	output
,	@oEmail			varchar(50)	output
,	@oEntryTime		datetime	output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vRequestNo		tinyint		-- 0: 아이디찾기, 1: 비밀번호찾기, 2: 이메일인증
		,	@vSendTime		datetime
		,	@vFinishTime	datetime
		,	@vErrorMsg		nvarchar(max)
	select	@oAccountNo	= 0
		,	@oAccountId	= ''
		,	@oEmail		= ''
		,	@oEntryTime	= ''
		,	@oReturnNo	= 0

	select	@oAccountNo		= cAccountNo
		,	@oEmail			= cEmail
		,	@vRequestNo		= cRequestNo
		,	@vSendTime		= cCreateTime
		,	@vFinishTime	= cFinishTime
	from	dbo.tEmailCert
	where	cCertNo			= @pCertNo

	-- 1.발송된 인증키가 존재하지 않습니다.
	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end

	-- 2.이메일 인증 대기시간이 20분이 지났습니다.
	if datediff(minute,@vSendTime,getdate()) > 20
	begin
		set @oReturnNo = 2
		return 2
	end

	-- 3.이메일 인증값 상태 체크. 이미 인증된 인증키 입니다.
	if @vFinishTime is not null
	begin
		set @oReturnNo = 3
		return 3
	end


	-- 4.회원상태 확인
	select	@oAccountId	= cAccountId
		,	@oEntryTime	= cCreateTime
	from	dbo.tAccountInfo
	where	cAccountNo	= @oAccountNo
		and	cDeleteTime	is null

	if @@rowcount = 0
	begin
		set @oReturnNo = 4
		return 4
	end


	begin try
		begin tran
			set @oReturnNo = 6
			-- 이메일 인증 이면..
			if @vRequestNo = 2
			begin
				update	a
				set		cCertfyTime	= getdate()
				from	dbo.tAccountInfo as a
				where	cAccountNo	= @oAccountNo
			end


			set @oReturnNo = 7
			update	a
			set		cFinishTime	= getdate()
			from	dbo.tEmailCert as a
			where	cCertNo		= @pCertNo

			-- 발송된 인증키가 존재하지 않습니다.
			if @@rowcount = 0
			begin
				select	@oReturnNo = -7
					,	@vErrorMsg = '@pCertNo = '+ rtrim(@pCertNo)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetFixCheckEmailCertKey to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetFixDeleteAccountCancel') is null
	exec ('create procedure dbo.uspSetFixDeleteAccountCancel as select 1')
--	drop procedure dbo.uspSetFixDeleteAccountCancel
go
/******************************************************************************
	Name		: dbo.uspSetFixDeleteAccountCancel
	Description	: 회원 탈퇴 취소
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixDeleteAccountCancel
(	@pAccountNo		bigint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare @vStatus int
	set @oReturnNo = -1

	select	@vStatus	= cStatus
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo

	-- 탈퇴 신청 대상자가 아닙니다.
	if @vStatus != 11
	begin
		set @oReturnNo = 1
		return
	end


	begin try
		begin tran
			set @oReturnNo = 2
			;with ctetWithdrawLog as (
				select	max(cLogs) as cLogs
				from	dbo.tWithdrawLog
				where	cAccountNo = @pAccountNo
			)
			update	b
			set		b.cCancelTime	= getdate()
			from	ctetWithdrawLog as a
					inner join
					dbo.tWithdrawLog as b
				on	b.cLogs			= a.cLogs
			where	b.cAccountNo	= @pAccountNo


			set @oReturnNo = 3
			update	a
			set		cStatus		= 1
				,	cDeleteTime	= null
			from	dbo.tAccountInfo as a
			where	cAccountNo	= @pAccountNo
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetFixDeleteAccountCancel to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetFixDeleteAccountComplete') is null
	exec ('create procedure dbo.uspSetFixDeleteAccountComplete as select 1')
--	drop procedure dbo.uspSetFixDeleteAccountComplete
go
/******************************************************************************
	Name		: dbo.uspSetFixDeleteAccountComplete
	Description	: 회원 탈퇴 완료
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixDeleteAccountComplete
(	@pAccountNo		bigint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare @vStatus int
	set @oReturnNo = -1

	select	@vStatus	= cStatus
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo

	-- 탈퇴 신청 대상자가 아닙니다.
	if @vStatus != 11
	begin
		set @oReturnNo = 1
		return 1
	end


	begin try
		begin tran
			set @oReturnNo = 2
			;with ctetWithdrawLog as (
				select	max(cLogs) as cLogs
				from	dbo.tWithdrawLog
				where	cAccountNo = @pAccountNo
			)
			update	b
			set		b.cDeleteTime	= getdate()
			from	ctetWithdrawLog as a
					inner join
					dbo.tWithdrawLog as b
				on	b.cLogs			= a.cLogs
			where	b.cAccountNo	= @pAccountNo


			set @oReturnNo = 3
			update	a
			set		cStatus		= 99
				,	cDeleteTime	= getdate()
			from	dbo.tAccountInfo as a
			where	cAccountNo	= @pAccountNo
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetFixDeleteAccountComplete to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetFixPassword') is null
	exec ('create procedure dbo.uspSetFixPassword as select 1')
--	drop procedure dbo.uspSetFixPassword
go
/******************************************************************************
	Name		: dbo.uspSetFixPassword
	Description	: 비밀번호 변경
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixPassword
(	@pAccountNo		bigint
,	@pPassword		char(32)
,	@pNewPassword	char(32)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vPassword binary(70)
	set @oReturnNo = -1

	select	@vPassword	= cPassword
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo
		and	cStatus		= 1

	if pwdcompare(@pPassword, @vPassword) = 0
	begin
		set @oReturnNo = -2
		return -2
	end


	begin try
		set @oReturnNo = 3
		update	a
		set		cPassword	= pwdencrypt(@pNewPassword)
		from	dbo.tAccountInfo as a
		where	cAccountNo	= @pAccountNo
			and	cStatus		= 1
	end try

	begin catch
		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetFixPassword to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetNewAccessToken') is null
	exec ('create procedure dbo.uspSetNewAccessToken as select 1')
--	drop procedure dbo.uspSetNewAccessToken
go
/******************************************************************************
	Name		: dbo.uspSetNewAccessToken
	Description	: api - AccessToken 생성
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewAccessToken
(	@pAccountNo		bigint
,	@pGameNo		int
,	@pRefresh		bit
,	@pSecret		char(27)
,	@oToken			char(36)	output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	begin try
		begin tran
			set @oReturnNo = 1
			update	a
			set		cToken =
						case
							when datediff(day,cModifyTime,getdate()) > 7 then newid()
							when @pRefresh = 1 then newid()
							else cToken
						end
				,	cSecret		= @pSecret
				,	cModifyTime	= getdate()
			from	dbo.tGuestConsumer as a
			where	cAccountNo	= @pAccountNo
				and cGameNo		= @pGameNo

			if @@rowcount = 0
			begin
				set @oReturnNo = 2
				insert into dbo.tGuestConsumer
					(	cAccountNo
					,	cGameNo
					,	cToken
					,	cSecret
					,	cModifyTime
					,	cCreateTime
					)
				values
					(	@pAccountNo
					,	@pGameNo
					,	newid()
					,	@pSecret
					,	getdate()
					,	getdate()
					)
			end
		commit tran


		select	@oToken		= cToken
		from	dbo.tGuestConsumer
		where	cAccountNo	= @pAccountNo
			and	cGameNo		= @pGameNo
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @o1 char(36)
,@sp int
,@rt int
exec @sp = dbo.uspSetNewAccessToken
 @pAccountNo = 100000001
,@pGameNo = 20150001
,@pRefresh = 0
,@pSecret = 'aifenfdurafoiuhjageitjooaij'
,@oToken = @o1 out
,@oReturnNo = @rt out

print @o1
print @sp
print @rt
*/
go

grant execute on dbo.uspSetNewAccessToken to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetNewAccount') is null
	exec ('create procedure dbo.uspSetNewAccount as select 1')
--	drop procedure dbo.uspSetNewAccount
go
/******************************************************************************
	Name		: dbo.uspSetNewAccount
	Description	: 회원 가입
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewAccount
(	@pAccountId		varchar(50)
,	@pPassword		char(32)
,	@pNickName		nvarchar(20)
,	@pEmail			varchar(50)
,	@pHostIp		varchar(15)
,	@pEmailAgree	bit
,	@oAccountNo		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	select	@oAccountNo	= 0
		,	@oReturnNo	= -1

	-- 1. 아이디 중복 검사
	if exists ( select 1 from dbo.tAccountInfo where cAccountId = @pAccountId )
	begin
		set @oReturnNo = 2
		return 2
	end

	-- 2. 닉네임 중복 검사
	if exists ( select 1 from dbo.tAccountInfo where cNickName = @pNickName )
	begin
		set @oReturnNo = 3
		return 3
	end


	begin try
		select	@oReturnNo	= 4
			,	@oAccountNo	= next value for dbo.sAccountNo

		insert into dbo.tAccountInfo
			(	cAccountNo
			,	cPublisher
			,	cAccountId
			,	cPassword
			,	cNickName
			,	cEmail
			,	cHostIp
			,	cStatus
			,	cIsEmail
			,	cCreateTime
			)
		values
			(	@oAccountNo
			,	1
			,	@pAccountId
			,	pwdencrypt(@pPassword)
			,	@pNickName
			,	@pEmail
			,	@pHostIp
			,	1
			,	@pEmailAgree
			,	getdate()
			)
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetNewAccount to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetNewDeleteAccount') is null
	exec ('create procedure dbo.uspSetNewDeleteAccount as select 1')
--	drop procedure dbo.uspSetNewDeleteAccount
go
/******************************************************************************
	Name		: dbo.uspSetNewDeleteAccount
	Description	: 회원 탈퇴 신청
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewDeleteAccount
(	@pAccountNo		bigint
,	@pCategory		smallint
,	@pMemoText		nvarchar(200)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare @vStatus	int
		,	@vPublisher	tinyint
		,	@vAccountId	varchar(20)
	set @oReturnNo = -1

	select	@vPublisher	= cPublisher
		,	@vAccountId	= cAccountId
		,	@vStatus	= cStatus
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo

	-- 이미 탈퇴 신청이 된 회원 입니다.
	if @vStatus = 11
	begin
		set @oReturnNo = 1
		return
	end


	begin try
		begin tran
			set @oReturnNo = 2
			insert into dbo.tWithdrawLog
				(	cLogs
				,	cAccountNo
				,	cPublisher
				,	cAccountId
				,	cCategory
				,	cMemo
				,	cCreateTime
				)
			values
				(	next value for dbo.sDropNo
				,	@pAccountNo
				,	@vPublisher
				,	@vAccountId
				,	nullif(@pCategory,0)
				,	nullif(@pMemoText,'')
				,	getdate()
				)

			set @oReturnNo = 3
			update	a
			set		cStatus		= 11
				,	cDeleteTime	= getdate()
			from	dbo.tAccountInfo as a
			where	cAccountNo	= @pAccountNo
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetNewDeleteAccount to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetNewEmailCertKey') is null
	exec ('create procedure dbo.uspSetNewEmailCertKey as select 1')
--	drop procedure dbo.uspSetNewEmailCertKey
go
/******************************************************************************
	Name		: dbo.uspSetNewEmailCertKey
	Description	: 이메일 인증키 생성
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewEmailCertKey
(	@pAccountNo		bigint
,	@pEmail			varchar(50)
,	@pCertKey		char(36)
,	@pRequestNo		tinyint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	begin try
		set @oReturnNo = 1
		insert into dbo.tEmailCert
			(	cCertNo
			,	cAccountNo
			,	cEmail
			,	cCertKey
			,	cRequestNo
			,	cCreateTime
			)
		values
			(	next value for dbo.sCertNo
			,	@pAccountNo
			,	@pEmail
			,	@pCertKey
			,	@pRequestNo
			,	getdate()
			)


		-- 이메일 인증을 다시 하는 경우
		if @pRequestNo = 2
		begin
			update	a
			set		cCertfyTime	= null
			from	dbo.tAccountInfo as a
			where	cAccountNo	= @pAccountNo
		end
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspSetNewEmailCertKey to [sawebuser]
go

use AuthorityWeb
go
if object_id('dbo.uspSetNewErrorLog') is null
	exec ('create procedure dbo.uspSetNewErrorLog as select 1')
--	drop procedure dbo.uspSetNewErrorLog
go
/******************************************************************************
	Name		: dbo.uspSetNewErrorLog
	Description	: 에러로그 저장 (try catch 에서 실행되며 error_number()를 저장)
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 활성화 가능한 매장수 초과

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2014-09-23	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewErrorLog
(	@oErrorNo		int	output
,	@pPrintMsg		bit = 0

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vDataBase		nvarchar(128)	= db_name()
		,	@vProcedure		nvarchar(128)	= error_procedure()
		,	@vAuthName		sysname			= current_user
		,	@vLoginName		sysname			= original_login()
		,	@vHostName		nvarchar(128)	= host_name()
		,	@vSeverity		int				= error_severity()
		,	@vErrorState	int				= error_state()
		,	@vErrorNo		int				= error_number()
		,	@vErrorLine		int				= error_line()
		,	@vErrorMessage	nvarchar(max)	= error_message();

	insert into dbo.tSpErrorLog
		(	cLogs
		,	cDataBase
		,	cProcedure
		,	cAuther
		,	cLoginName
		,	cHostName
		,	cErrorNo
		,	cUserError
		,	cSeverity
		,	cState
		,	cLineNo
		,	cErrorMessage
		,	cCreateTime
		)
	values
		(	next value for dbo.sErrorNo
		,	@vDataBase
		,	@vProcedure
		,	@vAuthName
		,	@vLoginName
		,	@vHostName
		,	@vErrorNo
		,	@oErrorNo
		,	@vSeverity
		,	@vErrorState
		,	@vErrorLine
		,	@vErrorMessage
		,	getdate()
		);

	-- print error information
	if @pPrintMsg = 1
	begin
		print	'error number : '+ rtrim(isnull(@vErrorNo,0))
			+	', severity : '+ rtrim(isnull(@vSeverity,0))
			+	', state : '+ rtrim(isnull(@vErrorState,0))
			+	', procedure : '+ isnull(@vProcedure,'-')
			+	', line number : '+ rtrim(isnull(@vErrorLine,0))

		print @vErrorMessage;
	end


	return @oErrorNo
end
/*
set statistics io on
use AuthorityWeb
declare
 @sp int
,@rt int = -10
exec @sp = dbo.uspSetNewErrorLog
 @oErrorNo = @rt output
,@pPrintMsg = 0

print @sp
print @rt
*/
go

