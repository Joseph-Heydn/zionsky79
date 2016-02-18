use TwelveskyWeb
go
if object_id('dbo.uspSetFileWrite') is null
	exec ('create procedure dbo.uspSetFileWrite as select 1')
--	drop procedure dbo.uspSetFileWrite
go
/******************************************************************************
	Name		: dbo.uspSetFileWrite
	Description	: 파일 추가
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error
					2	: error on DELETE
					3	: error on INSERT

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFileWrite
(	@pMenuNo		int
,	@pWriteNo		bigint
,	@pFileName		nvarchar(1000)
,	@pSaveName		varchar(1000)
,	@pFileExts		varchar(500)
,	@pFileSize		varchar(1000)
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vErrorMsg nvarchar(max) = ''
	set @oReturnNo = 1

	create table #tblFileList
	(	cFileName	nvarchar(100) collate SQL_Latin1_General_CP1_CI_AS not null
	,	cFileNo		bigint		not null
	,	cFileExt	char(3)		not null
	,	cFileSize	int			not null
	)


	begin try
		begin tran
			set @oReturnNo = 2
			-- 배열 형태 -> 테이블
			insert into #tblFileList
			exec dbo.uspArray2Table
					@pString0 = @pFileName
				,	@pString1 = @pSaveName
				,	@pString2 = @pFileExts
				,	@pString3 = @pFileSize

			if @@rowcount = 0
			begin
				select	@oReturnNo = -2
					,	@vErrorMsg += '@pMenuNo = '+ rtrim(@pMenuNo)
					,	@vErrorMsg += ', @pFileName = '+ rtrim(@pFileName)
					,	@vErrorMsg += ', @pSaveName = '+ rtrim(@pSaveName)
					,	@vErrorMsg += ', @pFileSize = '+ rtrim(@pFileSize)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end


			set @oReturnNo = 3
			-- 삭제 된 파일
			delete	b
			from	dbo.tFileInfo as a
					left outer join
					#tblFileList as b
				on	a.cMenuNo	= @pMenuNo
				and	a.cWriteNo	= @pWriteNo
				and	b.cFileNo	= a.cFileNo
			where	b.cFileNo	is null


			set @oReturnNo = 4
			-- 추가 된 파일
			insert into dbo.tFileInfo
				(	cMenuNo
				,	cWriteNo
				,	cFileNo
				,	cFileName
				,	cFileExt
				,	cFileSize
				,	cCreateTime
				)
			select	@pMenuNo
				,	@pWriteNo
				,	a.cFileNo
				,	a.cFileName
				,	a.cFileExt
				,	a.cFileSize
				,	getdate()
			from	#tblFileList as a
					left outer join
					dbo.tFileInfo as b
				on	b.cWriteNo	= @pWriteNo
				and	b.cFileNo	= a.cFileNo
			where	b.cFileNo	is null
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
/*
set statistics io on
use TwelveskyWeb
declare
 @o1 bigint
,@sp int
,@rt int
exec @sp = dbo.uspSetFileWrite
 @pMenuNo = 1000001
,@pWriteNo = 10001
,@pFileName = N'가나다.jpg|핥핥핥.jpg|'
,@pSaveName = '987657|9879|'
,@pFileExts = 'jpg|jpg|'
,@pFileSize = '75148|87241|'
,@oWriteNo = @o1 out
,@oReturnNo = @rt out

print @o1
print @sp
print @rt


dbo.tFileInfo
where cWriteNo = 3713

dbo.tSpErrorLog
-- truncate table dbo.tFileInfo
*/
go

grant execute on dbo.uspSetFileWrite to [sawebuser]
go

