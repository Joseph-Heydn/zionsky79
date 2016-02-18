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

