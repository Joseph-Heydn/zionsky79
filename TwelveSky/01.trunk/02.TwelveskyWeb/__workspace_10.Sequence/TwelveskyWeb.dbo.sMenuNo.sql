use TwelveskyWeb
go
if object_id('dbo.sMenuNo') IS NOT NULL
begin
	print N'dbo.sMenuNo 시퀀스가 존재 합니다.'
	goto sMenuNo
	/**
		alter sequence dbo.sMenuNo restart with 1000001
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sMenuNo'
		drop sequence dbo.sMenuNo
	**/
end

create sequence dbo.sMenuNo
start with 1000001
increment by 1
cache 10

sMenuNo:
go

