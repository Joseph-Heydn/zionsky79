use TwelveskyWeb
go
if object_id('dbo.sFileNo') IS NOT NULL
begin
	print N'dbo.sFileNo 시퀀스가 존재 합니다.'
	goto sFileNo
	/**
		alter sequence dbo.sFileNo restart with 7000000001
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sFileNo'
		drop sequence dbo.sFileNo
	**/
end

create sequence dbo.sFileNo
start with 7000000001
increment by 1
cache 10

sFileNo:
go

