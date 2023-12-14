--커뮤니티 게시판
create table comm(
 comm_num number	not null,
 comm_title varchar2(150) not null,
 reg_date date not null,
 comm_content clob not null,
 comm_hit number(9) not null,
 modify_date	date,
 filename varchar2(150),
 ip	varchar2(40) not null,
 mem_num	number not null,
 constraint comm_pk primary key(comm_num),
 constraint comm_fk1 foreign key(mem_num) references member (mem_num)
);

create sequence comm_seq;

--커뮤니티 좋아요
create table comm_fav(
comm_num number not null,
mem_num not null,
constraint comm_fav_fk1 foreign key (comm_num) references comm (comm_num),
constraint comm_fav_fk2 foreign key (mem_num) references member (mem_num)
);

--커뮤니티 게시판 댓글
create table Comm_reply(
comm_renum number not null,
comm_recontent varchar2(900) not null,
comm_redate date default sysdate not null,
comm_remodifydate date,
comm_reip varchar2(40) not null,
comm_num number not null,
mem_num number not null,
constraint Comm_reply_pk primary key (comm_renum),
constraint Comm_reply_fk foreign key (comm_num) references comm (comm_num),
constraint Comm_reply_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence Comm_reply_seq;

--자주찾는 질문 게시판

CREATE TABLE faq (
  faq_num number NOT NULL,
  faq_title varchar2(100) not NULL,
  faq_content clob NOT NULL,
  faq_category number(1) NOT NULL ,
  constraint faq_pk primary key(faq_num)
);

