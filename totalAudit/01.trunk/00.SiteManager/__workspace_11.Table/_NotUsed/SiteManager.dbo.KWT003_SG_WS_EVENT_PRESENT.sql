use SiteManager
go
if object_id('dbo.KWT003_SG_WS_EVENT_PRESENT') is not null
begin
	print N'dbo.KWT003_SG_WS_EVENT_PRESENT 테이블이 존재 합니다.'
	goto KWT003_SG_WS_EVENT_PRESENT
	/**
		truncate table dbo.KWT003_SG_WS_EVENT_PRESENT
		drop table dbo.KWT003_SG_WS_EVENT_PRESENT
	**/
end

create table dbo.KWT003_SG_WS_EVENT_PRESENT
(	cEventNo		int				not null
,	cEventName		nvarchar(16)	not null
,	cNoteText		nvarchar(100)	not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT003_SG_WS_EVENT_PRESENT drop constraint PK_KWT003_SG_WS_EVENT_PRESENT_01
alter table dbo.KWT003_SG_WS_EVENT_PRESENT
add constraint PK_KWT003_SG_WS_EVENT_PRESENT_01
primary key clustered
(	cEventNo
)

truncate table dbo.KWT003_SG_WS_EVENT_PRESENT
insert into dbo.KWT003_SG_WS_EVENT_PRESENT
values
 (1,N'회귀유저'			,N'기간을 수정하여 이벤트 조절.'+ char(13) + N'한달에 한번만 하는 유저는 중복 지급 됨.',getdate())
,(2,N'튜토리얼'			,N'기간을 수정하여 이벤트 조절.'+ char(13) + N'튜토리얼 완료 선물 받았으면 중복 지급 안됨.',getdate())
,(3,N'월드보스'			,N'기간을 수정하여 이벤트 조절.'+ char(13) + N'기간을 길게 잡은 경우 매 월보마다 지급됨.',getdate())
,(4,N'조합 1+1'			,N'순번을 늘려서 이벤트 조절.'+ char(13) + N'일반 이벤트와 다른 Log Table 사용함.',getdate())
,(5,N'레벨업'			,N'순번 혹은 기간을 늘려서 이벤트 조절.',getdate())
,(6,N'월드보스 참여'		,N'순번 혹은 기간을 늘려서 이벤트 조절.'+ char(13) + N'기간은 다음 월보가 시작되기 전까지 잡는다!!',getdate())
,(7,N'아레나 참여'		,N'순번 혹은 기간을 늘려서 이벤트 조절.'+ char(13) + N'기간은 다음 시즌이 시작되기 전까지 잡는다.',getdate())
,(8,N'캐럿 구매 보너스'	,N'순번 혹은 기간을 늘려서 이벤트 조절.',getdate())
,(9,N'첫 구매 보너스'	,N'순번 혹은 기간을 늘려서 이벤트 조절.'+ char(13) + N'날짜가 절대 겹치지 않도록 주의 할 것!!',getdate())

,(1000000001	,N'임시점검'		,N'순번을 늘려서 이벤트 조절.',getdate())
,(1000000002	,N'접속장애'		,N'순번을 늘려서 이벤트 조절.',getdate())
,(1000000003	,N'업데이트기념'	,N'순번을 늘려서 이벤트 조절.',getdate())
,(1000000004	,N'깜짝선물'		,N'순번을 늘려서 이벤트 조절.',getdate())
,(1000000005	,N'불편보상'		,N'순번을 늘려서 이벤트 조절.',getdate())

KWT003_SG_WS_EVENT_PRESENT:
go

