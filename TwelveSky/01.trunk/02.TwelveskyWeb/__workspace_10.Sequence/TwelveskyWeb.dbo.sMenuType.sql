use TwelveskyWeb
go
if object_id('dbo.sMenuType') IS NOT NULL
begin
	print N'dbo.sMenuType 시퀀스가 존재 합니다.'
	goto sMenuType
	/**
		alter sequence dbo.sMenuType restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sMenuType'
		drop sequence dbo.sMenuType
	**/
end

create sequence dbo.sMenuType
start with 1
increment by 1
cache 10

sMenuType:
go

