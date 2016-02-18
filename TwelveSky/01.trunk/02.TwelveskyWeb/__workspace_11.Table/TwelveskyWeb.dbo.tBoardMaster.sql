use TwelveskyWeb
go
if object_id('dbo.tBoardMaster') is not null
begin
	print N'dbo.tBoardMaster 테이블이 존재 합니다.'
	goto tBoardMaster
	/**
		alter sequence dbo.sMenuNo restart with 1000001
		truncate table dbo.tBoardMaster
		drop table dbo.tBoardMaster
	**/
end


tBoardMaster:
go

