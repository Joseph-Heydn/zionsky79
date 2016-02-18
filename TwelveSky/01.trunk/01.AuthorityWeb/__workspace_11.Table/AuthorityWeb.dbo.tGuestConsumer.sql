use AuthorityWeb
go
if object_id('dbo.tGuestConsumer') is not null
begin
	print N'dbo.tGuestConsumer 테이블이 존재 합니다.'
	goto tGuestConsumer
	/**
		truncate table dbo.tGuestConsumer
		drop table dbo.tGuestConsumer
	**/
end

create table dbo.tGuestConsumer
(	cGameNo			int					not null
,	cAccountNo		bigint				not null
,	cToken			uniqueidentifier	not null
,	cSecret			char(27)			not null
,	cPlayerNo		bigint					null
,	cGameNick		nvarchar(20)			null
,	cModifyTime		datetime				null
,	cCreateTime		datetime			not null
)

-- alter table dbo.tGuestConsumer drop constraint PK_tGuestConsumer_01
alter table dbo.tGuestConsumer
add constraint PK_tGuestConsumer_01
primary key clustered
(	cAccountNo
,	cGameNo
)

-- drop index tGuestConsumer.IX_tGuestConsumer_02
create unique nonclustered index IX_tGuestConsumer_02
on	dbo.tGuestConsumer
(	cToken
)
include
(	cSecret
,	cPlayerNo
)

-- drop index tGuestConsumer.IX_tGuestConsumer_03
create unique nonclustered index IX_tGuestConsumer_03
on	dbo.tGuestConsumer
(	cGameNick
,	cGameNo
)
where cGameNick is not null

tGuestConsumer:
go

