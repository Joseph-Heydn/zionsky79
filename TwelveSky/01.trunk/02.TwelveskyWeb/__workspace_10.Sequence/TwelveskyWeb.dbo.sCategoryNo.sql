use TwelveskyWeb
go
if object_id('dbo.sCategoryNo') IS NOT NULL
begin
	print N'dbo.sCategoryNo 시퀀스가 존재 합니다.'
	goto sCategoryNo
	/**
		alter sequence dbo.sCategoryNo restart with 10001
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sCategoryNo'
		drop sequence dbo.sCategoryNo
	**/
end

create sequence dbo.sCategoryNo
start with 10001
increment by 1
cache 10

sCategoryNo:
go

