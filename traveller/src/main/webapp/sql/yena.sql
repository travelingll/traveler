create table event(
	event_num number not null,
	event_category number(1) not null,
	event_title varchar2(150) not null,
	event_start varchar2(10) not null,
	event_end varchar2(10) not null,
	event_photo1 varchar2(150),
	event_photo2 varchar2(150),
	event_photo3 varchar2(150),
	event_photo4 varchar2(150),
	event_photo5 varchar2(150),
	event_content clob not null,
	event_hit number(9) default 0 not null,
	event_regdate date default sysdate not null,
	event_modifydate date,
	event_count number not null,
	constraint event_pk primary key (event_num)
);

create sequence event_seq;

 --일대일 문의 게시판 테이블, 회원 관리 테이블 필요
create table question(
	question_num number not null,
	mem_num number not null,
	question_ip varchar2(40) not null,
	question_category number(1) not null,
	question_title varchar2(150) not null,
	question_lock number(1) not null,
	question_passwd varchar2(12),
	question_photo varchar2(150),
	question_content clob not null,
	question_regdate date default sysdate not null,
	question_modifydate date,
	question_level number(1) not null,
	constraint question_pk primary key (question_num),
	constraint question_fk foreign key (mem_num) references member (mem_num)
);

create sequence question_seq;

 --장바구니 테이블, 여행 상품 테이블 필요
create table cart(
	cart_num number not null,
	mem_num number not null,
	item_num number not null,
	cart_regdate date default sysdate not null,
	cart_count number not null,
	constraint cart_pk primary key (cart_num),
	constraint cart_fk1 foreign key (mem_num) references member (mem_num),
	constraint cart_fk2 foreign key (item_num) references item (item_num)
);

create sequence cart_seq;