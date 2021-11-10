-- DB 파트
DROP TABLE RESERVATIONS;
DROP TABLE LROOM;
DROP TABLE LIBRARY;
DROP TABLE LMEMBER;

CREATE TABLE LMEMBER(
	MID NUMBER(7), -- LMEMBER PK KEY
	MName NVARCHAR2(10) NOT NULL, --회원이름
	ID VARCHAR2(15) UNIQUE NOT NULL, --회원아이디
	Pwd VARCHAR2(20) NOT NULL, --회원 비밀번호
	MPhone VARCHAR2(20) NOT NULL, --회원 전화번호
	CONSTRAINT LMEMBER_PK PRIMARY KEY(MID)
);

CREATE TABLE LIBRARY(
	LID NUMBER(3), -- LIBRARY PK KEY
	LName NVARCHAR2(20) NOT NULL, --도서관 지점이름
	LLoc NVARCHAR2(30) NOT NULL, --도서관 위치	
	LPhone NVARCHAR2(20) NOT NULL, --도서관 전화번호
	CONSTRAINT LIBRARY_PK PRIMARY KEY(LID)
);

CREATE TABLE LROOM(
	RID NUMBER(3), -- LROOM PK KEY
	LID, -- 소속 도서관
	RName NVARCHAR2(30) NOT NULL, -- 스터디방 이름
	Capacity NUMBER(2), -- 몇인실인지
	PC NUMBER(2), -- 공용컴퓨터개수		
	CONSTRAINT LROOM_PK PRIMARY KEY(RID),
	CONSTRAINT LROOM_LIBRARY_FK FOREIGN KEY(LID) REFERENCES LIBRARY(LID)
);

CREATE TABLE RESERVATIONS(
	VNUM NUMBER(10), -- RESERVATIONS PK KEY
	MID, -- 예약한 사람
	RID, -- 예약한 방
	VDate DATE, -- 예약한 날짜
	VStartTime NUMBER(2), -- 예약시간대
	VEndTime NUMBER(2), -- 예약종료시간대
	CONSTRAINT RESERVATIONS_PK PRIMARY KEY(VNUM),
	CONSTRAINT RESERVATIONS_LMEM_FK FOREIGN KEY(MID) REFERENCES LMEMBER(MID),
	CONSTRAINT RESERVATIONS_LROOM_FK FOREIGN KEY(RID) REFERENCES LROOM(RID)
);

-- 시퀀스 파트
DROP SEQUENCE LMEM_SEQ;
DROP SEQUENCE LIBRARY_SEQ;
DROP SEQUENCE LROOM_SEQ;
DROP SEQUENCE RESERVE_SEQ;
CREATE SEQUENCE LMEM_SEQ NOCACHE;
CREATE SEQUENCE LIBRARY_SEQ NOCACHE;
CREATE SEQUENCE LROOM_SEQ NOCACHE;
CREATE SEQUENCE RESERVE_SEQ;

-- 기본 자료 삽입
INSERT into LMEMBER Values(LMEM_SEQ.NEXTVAL, 'admin', 'admin', 'admin', '112');
INSERT into LMEMBER Values(LMEM_SEQ.NEXTVAL, '김인회', 'dlsghl92', '1234', '010-3334-3316');
Insert into LIBRARY Values(LIBRARY_SEQ.NEXTVAL, '고양원흥', '고양시 덕양구 원흥동 도래울로 85', '031-8075-3316');
Insert into LIBRARY Values(LIBRARY_SEQ.NEXTVAL, '화정', '고양시 덕양구 은빛로77번길 8', '031-8075-9215');
Insert into LIBRARY Values(LIBRARY_SEQ.NEXTVAL, '일산동구', '고양시 일산동구 백석1동 일산로 118', '031-8075-9090');
Insert into LROOM VALUES(LROOM_SEQ.NEXTVAL, 1, '다목적실 4인실-1', 4, 0 );
Insert into LROOM VALUES(LROOM_SEQ.NEXTVAL, 1, '다목적실 4인실-2', 4, 0);
Insert into LROOM VALUES(LROOM_SEQ.NEXTVAL, 1, '다목적실 8인실-1', 8, 1);
INSERT INTO RESERVATIONS VALUES (RESERVE_SEQ.NEXTVAL, 2, 1, SYSDATE, 11, 13);
INSERT INTO RESERVATIONS VALUES (RESERVE_SEQ.NEXTVAL, 1, 1, SYSDATE, 14, 15);
insert into lroom values (lroom_seq.nextval, 2, '화정 별꿈회의실-1', 4, 0);
insert into lroom values (lroom_seq.nextval, 2, '화정 별꿈회의실-2', 4, 0);
COMMIT;