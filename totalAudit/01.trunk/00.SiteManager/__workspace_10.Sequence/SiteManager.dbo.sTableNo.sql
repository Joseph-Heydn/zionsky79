use SiteManager
go
if object_id('dbo.sTableNo') IS NOT NULL
begin
	print N'dbo.sTableNo 시퀀스가 존재 합니다.'
	goto sTableNo
	/**
		alter sequence dbo.sTableNo restart with 1000001
		select name, start_value, increment, cache_size from sys.sequences where name = 'sTableNo'
		drop sequence dbo.sTableNo
	**/
end

create sequence dbo.sTableNo
start with 1000001
increment by 1
cache 10

sTableNo:
go

