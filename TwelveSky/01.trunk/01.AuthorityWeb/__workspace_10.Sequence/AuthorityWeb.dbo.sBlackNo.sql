use AuthorityWeb
go
if object_id('dbo.sBlockNo') IS NOT NULL
begin
	print N'dbo.sBlockNo 시퀀스가 존재 합니다.'
	goto sBlockNo
	/**
		alter sequence dbo.sBlockNo restart with 1
		select name, start_value, increment, cache_size from sys.sequences where name = 'sBlockNo'
		drop sequence dbo.sBlockNo
	**/
end

create sequence dbo.sBlockNo
start with 1
increment by 1
cache 10

sBlockNo:
go

