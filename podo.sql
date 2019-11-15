DROP TABLE "TB_MEMBER" CASCADE CONSTRAINTS;
DROP TABLE "TB_REVIEW";
DROP TABLE "TB_LIKE";
DROP TABLE "TB_FILM" CASCADE CONSTRAINTS;
DROP TABLE "TB_DETAIL_FILM" CASCADE CONSTRAINTS;
DROP TABLE "TB_BOARD";
DROP TABLE "TB_RATING_FILM";
DROP TABLE "TB_COMMENT";
DROP TABLE "TB_INQUIRY";
DROP TABLE "TB_NOTICE";
DROP TABLE "TB_COLLECTION" CASCADE CONSTRAINTS;
DROP TABLE "TB_FILM_COLLECTION";
DROP TABLE "TB_REPORT";
DROP TABLE "TB_BLACK_MEMBER";
DROP TABLE "TB_ACTOR" CASCADE CONSTRAINTS;
DROP TABLE "TB_IMAGE";
DROP TABLE "TB_FILM_IMAGE";
DROP TABLE "TB_FILM_ACTOR";
DROP TABLE "TB_RATING_REVIEW";
DROP TABLE "TB_GENRE" CASCADE CONSTRAINTS;
DROP TABLE "TB_MEMBER_GENRE";

DROP SEQUENCE SEQ_MEMBER_ID;
DROP SEQUENCE SEQ_REVIEW_ID;
DROP SEQUENCE SEQ_LIKE_ID;
DROP SEQUENCE SEQ_FILM_ID;
DROP SEQUENCE SEQ_DFILM_ID;
DROP SEQUENCE SEQ_BOARD_ID;
DROP SEQUENCE SEQ_RATING_FILM_ID;
DROP SEQUENCE SEQ_COMMENT_ID;
DROP SEQUENCE SEQ_INQUERY_ID;
DROP SEQUENCE SEQ_NOTICE_ID;
DROP SEQUENCE SEQ_COLLECTION_ID;
DROP SEQUENCE SEQ_REPORT_ID;
DROP SEQUENCE SEQ_BLACK_ID;
DROP SEQUENCE SEQ_ACTOR_ID;
DROP SEQUENCE SEQ_IMAGE_ID;
DROP SEQUENCE SEQ_FIMAGE_ID;
DROP SEQUENCE SEQ_RATING_REVIEW_ID;
DROP SEQUENCE SEQ_GENRE_ID;

CREATE SEQUENCE SEQ_MEMBER_ID;
CREATE SEQUENCE SEQ_REVIEW_ID;
CREATE SEQUENCE SEQ_LIKE_ID;
CREATE SEQUENCE SEQ_FILM_ID;
CREATE SEQUENCE SEQ_DFILM_ID;
CREATE SEQUENCE SEQ_BOARD_ID;
CREATE SEQUENCE SEQ_RATING_FILM_ID;
CREATE SEQUENCE SEQ_COMMENT_ID;
CREATE SEQUENCE SEQ_INQUERY_ID;
CREATE SEQUENCE SEQ_NOTICE_ID;
CREATE SEQUENCE SEQ_COLLECTION_ID;
CREATE SEQUENCE SEQ_REPORT_ID;
CREATE SEQUENCE SEQ_BLACK_ID;
CREATE SEQUENCE SEQ_ACTOR_ID;
CREATE SEQUENCE SEQ_IMAGE_ID;
CREATE SEQUENCE SEQ_FIMAGE_ID;
CREATE SEQUENCE SEQ_RATING_REVIEW_ID;
CREATE SEQUENCE SEQ_GENRE_ID;


CREATE TABLE "TB_MEMBER" (
	"ID"	NUMBER		NOT NULL,
	"IMAGE"	VARCHAR2(200)	DEFAULT 'DEFAULT IMAGE PATH'	NOT NULL,
	"EMAIL"	VARCHAR2(30)		NOT NULL,
	"PWD"	VARCHAR2(1000)		NOT NULL,
	"NICKNAME"	VARCHAR2(30)		NOT NULL,
	"STATUS"	VARCHAR2(2)	DEFAULT 'Y'	NOT NULL,
	"ENROLL_DATE"	TIMESTAMP		NOT NULL,
	"MODIFY_DATE"	TIMESTAMP		NOT NULL,
	"GOOGLE_ID"	NUMBER		NULL,
	"KAKAO_ID"	NUMBER		NULL
);

CREATE TABLE "TB_REVIEW" (
	"ID"	NUMBER		NOT NULL,
	"CONTENT"	CLOB		NOT NULL,
	"INAPPROPRIATE_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"SPOILER_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"LIKE_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"SPOILER_CHECK"	NUMBER	DEFAULT 1	NOT NULL,
	"STATUS"	VARCHAR2(2)	DEFAULT 'Y'	NOT NULL,
	"FILM_ID"	NUMBER		NOT NULL,
	"MEMBER_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_LIKE" (
	"ID"	NUMBER		NOT NULL,
	"TYPE"	NUMBER		NOT NULL,
	"TARGET_ID"	NUMBER		NOT NULL,
	"USER_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_FILM" (
	"ID"	NUMBER		NOT NULL,
	"TITLE_KOR"	VARCHAR2(100)		NULL,
	"TITLE_ENG"	VARCHAR2(100)		NULL,
	"DIRECTOR"	VARCHAR2(50)		NULL,
	"RELEASE_YEAR"	NUMBER		NOT NULL,
	"PRODUCTION_COUNTRY"	VARCHAR2(50)		NOT NULL,
	"PRODUCTION_STATUS"	VARCHAR2(30)		NOT NULL,
	"GENRE_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_DETAIL_FILM" (
	"ID"	NUMBER		NOT NULL,
	"SYNOPSYS"	CLOB		NULL,
	"TRIVIA"	CLOB		NULL,
	"TRAILER"	VARCHAR2(200)		NULL,
	"FOOTAGE"	VARCHAR2(200)		NULL,
	"STATUS"	VARCHAR2(2)	DEFAULT 'Y'	NOT NULL,
	"MEMBER_ID"	NUMBER		NOT NULL,
	"FILM_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_BOARD" (
	"ID"	NUMBER		NOT NULL,
	"TITLE"	VARCHAR2(300)		NOT NULL,
	"CONTENT"	CLOB		NOT NULL,
	"VIEW_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"INAPPROPRIATE_COUNT"	NUMBER		NULL,
	"SPOILER_COUNT"	NUMBER		NULL,
	"LIKE_COUNT"	NUMBER		NULL,
	"MODIFY_DATE"	TIMESTAMP		NOT NULL,
	"CREATE_DATE"	TIMESTAMP		NOT NULL,
	"STATUS"	VARCHAR2(2)	DEFAULT 'Y'	NOT NULL,
	"MEMBER_ID"	NUMBER		NOT NULL,
	"IMAGE_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_RATING_FILM" (
	"ID"	NUMBER		NOT NULL,
	"STAR"	NUMBER		NULL,
	"SAW"	VARCHAR2(2)	DEFAULT 'N'	NOT NULL,
	"MEMBER_ID"	NUMBER		NOT NULL,
	"FILM_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_COMMENT" (
	"ID"	NUMBER		NOT NULL,
	"TYPE"	NUMBER		NOT NULL,
	"CONTENT"	CLOB		NOT NULL,
	"INAPPROPRIATE_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"SPOILER_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"LIKE_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"CREATE_DATE"	TIMESTAMP		NOT NULL,
	"MODIFY_DATE"	TIMESTAMP		NOT NULL,
	"STATUS"	VARCHAR2(2)	DEFAULT 'Y'	NOT NULL,
	"LEVEL"	NUMBER	DEFAULT 0	NOT NULL,
	"MEMBER_ID"	NUMBER		NULL,
	"BOARD_ID"	NUMBER		NULL,
	"REVIEW_ID"	NUMBER		NULL
);

CREATE TABLE "TB_INQUIRY" (
	"ID"	NUMBER		NOT NULL,
	"TYPE"	NUMBER		NOT NULL,
	"CONTENT"	CLOB		NOT NULL,
	"CREATE_DATE"	TIMESTAMP		NOT NULL,
	"STATUS"	VARCHAR2(2)	DEFAULT 'Y'	NOT NULL,
	"USER_ID"	NUMBER		NOT NULL,
	"ANSWER"	CLOB		NULL,
	"ANSWER_DATE"	TIMESTAMP		NULL,
	"ADMIN_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_NOTICE" (
	"ID"	NUMBER		NOT NULL,
	"TITLE"	VARCHAR2(100)		NOT NULL,
	"CONTENT"	CLOB		NOT NULL,
	"VIEW_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"CREATE_DATE"	TIMESTAMP		NOT NULL,
	"MODIFY_DATE"	TIMESTAMP		NOT NULL,
	"IMAGE_ID"	NUMBER		NOT NULL,
	"ADMIN_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_COLLECTION" (
	"ID"	NUMBER		NOT NULL,
	"TITLE"	VARCHAR2(100)		NOT NULL,
	"CONTENT"	CLOB		NULL,
	"LIKE_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"INAPPROPRIATE_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"SPOILER_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"CREATE_DATE"	TIMESTAMP		NOT NULL,
	"MODIFY_DATE"	TIMESTAMP		NOT NULL,
	"STATUS"	VARCHAR2(2)	DEFAULT 'Y'	NOT NULL,
	"PRIVATE"	VARCHAR2(2)	DEFAULT 'N'	NOT NULL,
	"MEMBER_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_FILM_COLLECTION" (
	"COLLECTION_ID"	NUMBER		NOT NULL,
	"FILM_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_REPORT" (
	"ID"	NUMBER		NOT NULL,
	"TYPE"	NUMBER		NOT NULL,
	"TARGET_ID"	NUMBER		NOT NULL,
	"CONTENT"	NUMBER		NOT NULL,
	"REPORT_ID"	NUMBER		NOT NULL,
	"REPORTED_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_BLACK_MEMBER" (
	"ID"	NUMBER		NOT NULL,
	"DATE"	TIMESTAMP	DEFAULT SYSDATE	NOT NULL,
	"TARGET_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_ACTOR" (
	"ID"	NUMBER		NOT NULL,
	"NAME"	VARCHAR2(50)		NOT NULL,
	"PROFILE_IMG"	VARCHAR2(300)		NOT NULL
);

CREATE TABLE "TB_IMAGE" (
	"ID"	NUMBER		NOT NULL,
	"PATH"	VARCHAR2(1000)		NOT NULL,
	"ORIGINAL_NAME"	VARCHAR2(1000)		NOT NULL,
	"CHANGE_NAME"	VARCHAR2(1000)		NOT NULL,
	"TYPE"	NUMBER		NOT NULL
);

CREATE TABLE "TB_FILM_IMAGE" (
	"ID"	NUMBER		NOT NULL,
	"TYPE"	NUMBER		NOT NULL,
	"PATH"	VARCHAR2(1000)		NOT NULL,
	"CHANGE_NAME"	VARCHAR2(1000)		NOT NULL,
	"DFILM_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_FILM_ACTOR" (
	"ACTOR_ID"	NUMBER		NOT NULL,
	"DFILM_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_RATING_REVIEW" (
	"ID"	NUMBER		NOT NULL,
	"RATING_SOUND"	NUMBER		NOT NULL,
	"RATING_VISUAL"	NUMBER		NOT NULL,
	"RATING_ACTING"	NUMBER		NOT NULL,
	"RATING_POP"	NUMBER		NOT NULL,
	"RATING_SCRIPT"	NUMBER		NOT NULL,
	"RATING_DIRECT"	NUMBER		NOT NULL,
	"REVIEW_ID"	NUMBER		NOT NULL,
	"MEMBER_ID"	NUMBER		NOT NULL
);

CREATE TABLE "TB_GENRE" (
	"ID"	NUMBER		NOT NULL,
	"NAME"	VARCHAR2(30)		NOT NULL
);

CREATE TABLE "TB_MEMBER_GENRE" (
	"MEMBER_ID"	NUMBER		NOT NULL,
	"GENRE_ID"	NUMBER		NOT NULL
);

ALTER TABLE "TB_MEMBER" ADD CONSTRAINT "PK_TB_MEMBER" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_REVIEW" ADD CONSTRAINT "PK_TB_REVIEW" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_LIKE" ADD CONSTRAINT "PK_TB_LIKE" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_FILM" ADD CONSTRAINT "PK_TB_FILM" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_DETAIL_FILM" ADD CONSTRAINT "PK_TB_DETAIL_FILM" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_BOARD" ADD CONSTRAINT "PK_TB_BOARD" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_RATING_FILM" ADD CONSTRAINT "PK_TB_RATING_FILM" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_COMMENT" ADD CONSTRAINT "PK_TB_COMMENT" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_INQUIRY" ADD CONSTRAINT "PK_TB_INQUIRY" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_NOTICE" ADD CONSTRAINT "PK_TB_NOTICE" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_COLLECTION" ADD CONSTRAINT "PK_TB_COLLECTION" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_FILM_COLLECTION" ADD CONSTRAINT "PK_TB_FILM_COLLECTION" PRIMARY KEY (
	"COLLECTION_ID",
	"FILM_ID"
);

ALTER TABLE "TB_REPORT" ADD CONSTRAINT "PK_TB_REPORT" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_BLACK_MEMBER" ADD CONSTRAINT "PK_TB_BLACK_MEMBER" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_ACTOR" ADD CONSTRAINT "PK_TB_ACTOR" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_IMAGE" ADD CONSTRAINT "PK_TB_IMAGE" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_FILM_IMAGE" ADD CONSTRAINT "PK_TB_FILM_IMAGE" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_FILM_ACTOR" ADD CONSTRAINT "PK_TB_FILM_ACTOR" PRIMARY KEY (
	"ACTOR_ID",
	"DFILM_ID"
);

ALTER TABLE "TB_RATING_REVIEW" ADD CONSTRAINT "PK_TB_RATING_REVIEW" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_GENRE" ADD CONSTRAINT "PK_TB_GENRE" PRIMARY KEY (
	"ID"
);

ALTER TABLE "TB_MEMBER_GENRE" ADD CONSTRAINT "PK_TB_MEMBER_GENRE" PRIMARY KEY (
	"MEMBER_ID",
	"GENRE_ID"
);

ALTER TABLE "TB_FILM_COLLECTION" ADD CONSTRAINT "FK_FILM_COLLECTION_C" FOREIGN KEY (
	"COLLECTION_ID"
)
REFERENCES "TB_COLLECTION" (
	"ID"
);

ALTER TABLE "TB_FILM_COLLECTION" ADD CONSTRAINT "FK_FILM_COLLECTION_F" FOREIGN KEY (
	"FILM_ID"
)
REFERENCES "TB_FILM" (
	"ID"
);

ALTER TABLE "TB_FILM_ACTOR" ADD CONSTRAINT "FK_FILM_ACTOR_A" FOREIGN KEY (
	"ACTOR_ID"
)
REFERENCES "TB_ACTOR" (
	"ID"
);

ALTER TABLE "TB_FILM_ACTOR" ADD CONSTRAINT "FK_FILM_ACTOR_D" FOREIGN KEY (
	"DFILM_ID"
)
REFERENCES "TB_DETAIL_FILM" (
	"ID"
);

ALTER TABLE "TB_MEMBER_GENRE" ADD CONSTRAINT "FK_MEMBER_GENRE_M" FOREIGN KEY (
	"MEMBER_ID"
)
REFERENCES "TB_MEMBER" (
	"ID"
);

ALTER TABLE "TB_MEMBER_GENRE" ADD CONSTRAINT "FK_MEMBER_GENRE_G" FOREIGN KEY (
	"GENRE_ID"
)
REFERENCES "TB_GENRE" (
	"ID"
);

insert into tb_genre values(seq_genre_id.nextval, '드라마');
insert into tb_genre values(seq_genre_id.nextval, '액션');
insert into tb_genre values(seq_genre_id.nextval, '다큐멘터리');

insert into tb_film
values(seq_film_id.nextval, '감쪽같은 그녀', 'A Little Princess', '허인무', 2019, '한국', '개봉예정', 1);
insert into tb_film
values(seq_film_id.nextval, '기생충', 'PARASITE', '봉준호', 2019, '한국', '개봉', 1);
insert into tb_film
values(seq_film_id.nextval, '녹차의 중력', 'Gravity of the Tea', '정성일', 2018, '한국', '개봉예정', 3);


