CREATE TABLE item (
item_num number not null,
item_name varchar2(30) not null,
item_content varchar2(300),
item_price number(10) not null,
item_img1 varchar2(30) not null,
item_img2 varchar2(30) not null,
item_img3 varchar2(30) not null,
item_img4 varchar2(30),
item_img5 varchar2(30),
item_img6 varchar2(30),
item_st1 varchar2(30),
item_st2 varchar2(30),
item_st3 varchar2(30),
date_start varchar2(10),
date_end varchar2(10),
item_case varchar2(20),
status varchar2(30) not null,
reg_date date default SYSDATE not null,
modify_date date,
quantity number(3) not null,
CONSTRAINT item_pk primary key (item_num)
);

CREATE sequence item_seq
	INCREMENT BY 1
	START WITH 100000
	MAXVALUE 100000000
	NOCYCLE;
	
CREATE TABLE item_fav(
item_num number(12) not null,
mem_num number not null,
constraint item_fav_fk1 foreign key (item_num) references item (item_num),
constraint item_fav_fk2 foreign key (mem_num) references member (mem_num)
);

CREATE TABLE item_reply(
item_renum number(5) not null,
item_num number(12) not null,
mem_num number not null,
item_recontent clob not null,
item_redate date default SYSDATE,
item_reip varchar2(30) not null,
item_st1 varchar2(20) not null,
item_case varchar2(20) not null,
user_id varchar2(20) not null,
constraint item_reply_pk primary key (item_renum),
constraint item_num_fk foreign key (item_num) references item (item_num),
constraint mem_num_fk foreign key (mem_num) references member (mem_num)
);

CREATE sequence item_renum
	INCREMENT BY 1
	START WITH 100000
	MAXVALUE 100000000
	NOCYCLE;
	
CREATE TABLE order_item( --주문건
order_num number(12) not null, --프라이머리키
item_name varchar2(4000) not null, --대표 상품명
order_price number(10) not null, --주문 전체 금액
order_custprice number(10) not null, --적립금 사용시 주문 전체 금액
mem_num number not null, --예약자
order_status number(1) not null, --예약 상태(1-예약 2-예약 완료 3-노쇼 5-예약 취소)
order_date date default SYSDATE, --예약 날짜
order_modate date, --예약 수정 날짜
notice varchar2(4000), --남기실 말씀
payment number(1) not null, --결제 수단
order_name varchar2(30) not null,
order_email varchar2(30) not null,
order_phone varchar2(30) not null,
order_birth varchar2(30) not null,
order_gender number(1) not null,
constraint order_num_pk primary key (order_num),
constraint mem_num_fk2 foreign key (mem_num) references member(mem_num)
);

CREATE sequence order_num_seq
	INCREMENT BY 1
	START WITH 100000
	MAXVALUE 100000000
	NOCYCLE;

CREATE TABLE order_detail ( --주문 상세
detail_num number(12) not null, --프라이머리키
item_num number(12) not null, --개별 상품 프라이머리 키
item_name varchar2(4000) not null, --개별 상품 이름
item_price number(10) not null, --개별 상품 가격
order_num number(12) not null, --주문 프라이머리 키
order_quantity number(3) not null, --개별 상품 주문 수량
constraint order_detail_pk1 primary key (detail_num),
constraint order_detail_fk2 foreign key (order_num) references order_item (order_num)
);







