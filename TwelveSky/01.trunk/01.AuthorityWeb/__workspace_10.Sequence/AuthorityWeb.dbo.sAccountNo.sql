use AuthorityWeb
go
if object_id('dbo.sAccountNo') IS NOT NULL
begin
	print N'dbo.sAccountNo 시퀀스가 존재 합니다.'
	goto sAccountNo
	/**
		alter sequence dbo.sAccountNo restart with 100000001
		select name, start_value, increment, cache_size from sys.sequences where name = 'sAccountNo'
		drop sequence dbo.sAccountNo
	**/
end

create sequence dbo.sAccountNo
start with 100000001
increment by 1
cache 100

sAccountNo:
go

