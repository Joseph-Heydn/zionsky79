use TwelveskyWeb
go
if object_id('dbo.tCommentInfo') is not null
begin
	print N'dbo.tCommentInfo 테이블이 존재 합니다.'
	goto tCommentInfo
	/**
		alter sequence dbo.sCommtNo restart with 1
		truncate table dbo.tCommentInfo
		drop table dbo.tCommentInfo
	**/
end

create table dbo.tCommentInfo
(	cMenuNo			int				not null
,	cWriteNo		bigint			not null
,	cCommtNo		bigint			not null
,	cAccountNo		bigint			not null
,	cAccountId		varchar(20)			null
,	cWriter			nvarchar(20)	not null
,	cComments		nvarchar(max)	not null
,	cHostIp			varchar(15)		not null
,	cView			bit				not null
,	cDrop			bit				not null
,	cRecmdCnt		int					null	-- 추천 수
,	cAgnstCnt		int					null	-- 반대 수
,	cRepotCnt		int					null	-- 신고 수
,	cDeleteTime		datetime			null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

-- drop index tCommentInfo.IX_tCommentInfo_02
-- alter table dbo.tCommentInfo drop constraint PK_tCommentInfo_01
alter table dbo.tCommentInfo
add constraint PK_tCommentInfo_01
primary key clustered
(	cWriteNo
,	cCommtNo desc
)

-- drop index tCommentInfo.IX_tCommentInfo_02
create unique nonclustered index IX_tCommentInfo_02
on	dbo.tCommentInfo
(	cWriteNo
,	cCommtNo desc
)
include
(	cDrop
)

alter table dbo.tCommentInfo add constraint DF_tCommentInfo_01 default(next value for dbo.sCommtNo) for cCommtNo

tCommentInfo:
go

