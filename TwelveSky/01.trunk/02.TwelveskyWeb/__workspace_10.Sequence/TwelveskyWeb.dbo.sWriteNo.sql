use TwelveskyWeb
go
if object_id('dbo.sWriteNo') IS NOT NULL
begin
	print N'dbo.sWriteNo �������� ���� �մϴ�.'
	goto sWriteNo
	/**
		alter sequence dbo.sWriteNo restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sWriteNo'
		drop sequence dbo.sWriteNo
	**/
end

create sequence dbo.sWriteNo
start with 1
increment by 1
cache 10

sWriteNo:
go

