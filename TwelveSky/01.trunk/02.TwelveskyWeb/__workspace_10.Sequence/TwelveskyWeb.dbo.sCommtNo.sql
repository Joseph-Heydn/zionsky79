use TwelveskyWeb
go
if object_id('dbo.sCommtNo') IS NOT NULL
begin
	print N'dbo.sCommtNo 시퀀스가 존재 합니다.'
	goto sCommtNo
	/**
		alter sequence dbo.sCommtNo restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sCommtNo'
		drop sequence dbo.sCommtNo
	**/
end

create sequence dbo.sCommtNo
start with 1
increment by 1
cache 300

sCommtNo:
go

