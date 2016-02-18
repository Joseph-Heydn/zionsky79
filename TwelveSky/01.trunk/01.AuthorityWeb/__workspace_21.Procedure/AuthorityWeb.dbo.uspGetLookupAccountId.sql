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

