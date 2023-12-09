create table member(
 mem_num number not null,
 id varchar2(12) unique not null,
 auth number(1) default 3 not null, --회원등급:0.탈퇴 1.VVIP 2.VIP 3.일반 9.관리
 constraint member_pk primary key (mem_num)
);

create table member_detail(
 mem_num number not null,
 name varchar2(30) not null,
 passwd varchar2(12) not null,
 phone varchar2(15) not null,
 email varchar2(50) not null,
 birth varchar2(8) not null,
 gender varchar2(1) not null, --회원성별:남자(M), 여자(F)
 zipcode varchar2(5) not null,
 address1 varchar2(90) not null,
 address2 varchar2(90) not null,
 style1 number(1) not null,
 style2 number(1) not null,
 style3 number(1) not null,
 push varchar2(1) not null, --동의(Y), 비동의(N)
 photo varchar2(150), --null 인정
 reg_date date default sysdate not null,
 modify_date date, --null 인정
 constraint member_detail_pk primary key (mem_num),
 constraint member_detail_fk foreign key (mem_num) references member(mem_num)
);
create sequence member_seq;

create table push(
 push_num number(1) not null,
 push_detail varchar2(4000) not null, 
 constraint push_pk primary key (push_num)
);
create sequence push_seq;

create table money(
 sm_num number not null,
 mem_num number not null,
 saved_money varchar2(50),
 sm_date date default sysdate not null,
 constraint money_pk primary key (sm_num),
 constraint money_fk foreign key (mem_num) references member(mem_num)
);
create sequence money_seq;