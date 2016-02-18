use TwelveskyWeb
go
if object_id('dbo.uspSetNewErrorLog') is null
	exec ('create procedure dbo.uspSetNewErrorLog as select 1')
--	drop procedure dbo.uspSetNewErrorLog
go
/******************************************************************************
	Name		: dbo.uspSetNewErrorLog
	Description	: 에러로그 저장 (TRY CATCH 에서 실행되며 error_number()를 저장)
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
use TwelveskyWeb
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

