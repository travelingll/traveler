CREATE TABLE item (
item_num number(12) not null,
item_name varchar2(30) not null,
item_content varchar2(300),
item_price_adult number(10) not null,
item_price_kid number(10) not null,
item_img1 varchar2(30) not null,
item_img2 varchar2(30) not null,
item_img3 varchar2(30) not null,
item_img4 varchar2(30),
item_img5 varchar2(30),
item_img6 varchar2(30),
item_st1 number(5),
item_st2 number(5),
item_st3 number(5),
date_start varchar2(10),
date_end varchar2(10),
status number(1) not null,
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
item_retitle varchar2(150) not null,
item_recontent clob not null,
item_redate date default SYSDATE,
item_remodate date not null,
item_reip varchar2(30) not null,
constraint item_reply_pk primary key (item_renum),
constraint item_num_fk foreign key (item_num) references item (item_num),
constraint mem_num_fk foreign key (mem_num) references member (mem_num)
);

CREATE sequence item_renum
	INCREMENT BY 1
	START WITH 100000
	MAXVALUE 100000000
	NOCYCLE;
	
CREATE TABLE order_item(
order_num number(12) not null,
item_num number(12) not null,
item_price_adult number(10) not null,
item_price_kid number(10) not null,
item_custprice number(10) not null,
mem_num number not null,
order_status number(1) not null,
order_date date default SYSDATE,
order_modate date,
notice varchar2(4000),
payment number(1) not null,
constraint order_num_pk primary key (order_num),
constraint item_num_fk2 foreign key (item_num) references item(item_num),
constraint mem_num_fk2 foreign key (mem_num) references member(mem_num)
);

CREATE sequence order_num_seq
	INCREMENT BY 1
	START WITH 100000
	MAXVALUE 100000000
	NOCYCLE;

CREATE TABLE order_detail (
detail_num number(12) not null,
item_num number(12) not null,
item_name varchar2(30) not null,
item_price_adult number(10) not null,
item_price_kid number(10) not null,
order_num number(12) not null,
order_quantity_adult number(3) not null,
order_quantity_kid number(3) not null,
constraint order_detail_pk primary key (detail_num),
constraint order_detail_fk foreign key (order_num) references order_item (order_num)
);

CREATE TRIGGER set_item_price_child
BEFORE INSERT ON order_item
FOR EACH ROW
BEGIN
    SET NEW.item_price_kid = NEW.item_price_adult * 0.8;
END;







