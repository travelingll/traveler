--동행 찾기 게시판
create table accom(
 accom_num number not null,
 mem_num number not null,
 accom_status number(1) not null,
 accom_title varchar2(150) not null,
 accom_content clob not null,
 accom_hit number(9) not null,
 accom_regdate date default sysdate not null,
 accom_modifydate date,
 accom_quantity number(3) not null,
 accom_expense number(10) not null,
 accom_filename varchar2(150) not null,
 accom_start varchar2(10) not null,
 accom_end varchar2(10) not null,
 ip varchar2(40) not null,
 constraint accom_pk primary key(accom_num),
 constraint accom_fk foreign key(mem_num) references member(mem_num)
);
create sequence accom_seq;

-- 동행 신청 내역 
create table accom_info(
 accom_num number not null,
 mem_num number not null,
 accom_yn number(1) not null,
 ip varchar2(40) not null,
 constraint accom_info_pk primary key(accom_num),
 constraint accom_info_fk foreign key(mem_num) references member(mem_num) 
);
create sequence accom_info_seq;

-- 동행 좋아요
create table accom_fav(
 accom_num number not null,
 mem_num number not null,
 constraint accom_fav_fk1 foreign key(accom_num) references accom(accom_num),
 constraint accom_fav_fk2 foreign key(mem_num) references member(mem_num) 
);

-- 동행 댓글
create table accom_reply(
 accom_renum number not null,
 mem_num number not null,
 accom_num number not null,
 accom_recontent varchar2(900) not null,
 accom_redate date default sysdate not null,
 accom_remodifydate date,
 accom_reip varchar2(40) not null,
 constraint accom_reply_pk primary key(accom_renum),
 constraint accom_reply_fk1 foreign key(mem_num) references member(mem_num),
 constraint accom_reply_fk2 foreign key(accom_num) references accom(accom_num)
);
create sequence accom_reply_seq;

