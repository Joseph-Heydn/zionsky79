use TwelveskyWeb
go
if object_id('dbo.tCategoryInfo') is not null
begin
	print N'dbo.tCategoryInfo 테이블이 존재 합니다.'
	goto tCategoryInfo
	/**
		alter sequence dbo.sCategoryNo restart with 10001
		truncate table dbo.tCategoryInfo
		drop table dbo.tCategoryInfo
	**/
end


tCategoryInfo:
go

