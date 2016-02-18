use TwelveskyWeb
go
if object_id('dbo.tArticleInfo.') is not null
begin
	print N'dbo.tArticleInfo. 테이블이 존재 합니다.'
	goto tArticleInfo.
	/**
		alter sequence dbo.sWriteNo restart with 1
		truncate table dbo.tArticleInfo.
		drop table dbo.tArticleInfo.
	**/
end


tArticleInfo.:
go

