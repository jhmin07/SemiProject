show user; 

-------------------------------------------------------------------------------------------
-- ==================================회원/관리자/로그인 관련====================================
--------------------------------------------------------------------------------------------

-- TBL_MEMBER 테이블 생성하기
create table tbl_member
(userid             varchar2(40)   not null  -- 회원아이디
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,name               varchar2(30)   not null  -- 회원명
,email              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,mobile             varchar2(200)            -- 연락처 (AES-256 암호화/복호화 대상) 
,postcode           varchar2(5)              -- 우편번호
,address            varchar2(200)            -- 주소
,detailaddress      varchar2(200)            -- 상세주소
,extraaddress       varchar2(200)            -- 참고항목
,gender             varchar2(1)              -- 성별   남자:1  / 여자:2
,birthday           varchar2(10)             -- 생년월일   
,point              number default 0         -- 포인트 
,registerday        date default sysdate     -- 가입일자 
,lastpwdchangedate  date default sysdate     -- 마지막으로 암호를 변경한 날짜  
,status             number(1) default 1 not null     -- 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
,idle               number(1) default 0 not null     -- 휴면유무      0 : 활동중  /  1 : 휴면중 
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint CK_tbl_member_status check( status in(0,1) )
,constraint CK_tbl_member_idle check( idle in(0,1) )
);

insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
values ('admin1', 'qwer1234!', '관리자1', 'test1@naver.com', '010-5678-3456', '01234', '서울시', '마포구', '123', '1', '1995-01-01');
insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
values ('admin2', 'qwer1234!', '테스트2', 'test2@naver.com', '010-5555-3456', '01234', '서울시', '마포구', '123', '1', '1995-01-01');

update tbl_member set userid = 'admin' where userid = 'admin1';
commit;

select *
from tbl_member
order by registerday desc;

-- 로그인 기록을 위한 테이블 생성하기 --

create table tbl_loginhistory
(fk_userid   varchar2(40) not null 
,logindate   date default sysdate not null
,clientip    varchar2(20) not null
,constraint FK_tbl_loginhistory foreign key(fk_userid) 
                                references tbl_member(userid)  
);

select *
from tbl_loginhistory;

-- 관리자 테이블 생성
create table tbl_admin
(adId             varchar2(40)   not null  -- 회원아이디
,adPwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,adName               varchar2(30)   not null  -- 회원명
,adEmail              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,adMobile             varchar2(200)            -- 연락처 (AES-256 암호화/복호화 대상) 
,constraint PK_tbl_member_userid primary key(adId)
--,constraint UQ_tbl_member_email  unique(email)-- 이메일은 같은 회사이메일을 사용한다는 조건이 있을 수 도 있음?
);

insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
values ('admin1', 'qwer1234!', '관리자1', 'test1@naver.com', '010-5678-3456', '01234', '서울시', '마포구', '123', '1', '1995-01-01');
insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
values ('admin2', 'qwer1234!', '테스트2', 'test2@naver.com', '010-5555-3456', '01234', '서울시', '마포구', '123', '1', '1995-01-01');

update tbl_member set userid = 'admin' where userid = 'admin1';
commit;

select *
from tbl_admin;

-------------------------------------------------------------------------------------------
-- ====================================관리자 회원관리======================================
-------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--- *** 오라클에서 프로시저를 사용하여 회원을 대량으로 입력(insert)한다. *** ---
select *
from user_constraints
where table_name = 'TBL_MEMBER';

-- 이메일을 대량으로 넣기 위해 어쩔 수 없이 email에 대한 unique 제약을 없애도록 한다.
alter table tbl_member
drop constraint UQ_TBL_MEMBER_EMAIL;

select *
from tbl_member
order by registerday desc;
-- admin 과 동일한 정보
-- pwd: qwer1234$ email: admin5@naver.com mobile: 01050505050

create or replace procedure pcd_tbl_member_insert
(p_userid   IN      varchar2
,p_name     IN      varchar2
,p_gender   IN      varchar2)
is
begin
    for i in 1..100 loop
        insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
        values(p_userid||i, '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', p_name||i, 'cxVL+tRNzHaO7lLS3ZxY+6Cjj4ip6eyCtPp8d0hDht8=', 'kbv4JIm7Z/3++0k4OgBUtw==', '03900', '서울 마포구 가양대로 1', '123동 5678호', ' (상암동)', p_gender, '1995-01-02');
    end loop;
end pcd_tbl_member_insert;
-- Procedure PCD_TBL_MEMBER_INSERT이(가) 컴파일되었습니다.

exec pcd_tbl_member_insert('kimys', '김유신', '1');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
commit;

exec pcd_tbl_member_insert('youks', '유관순', '2');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
commit;

select *
from tbl_member
order by name asc;

select count(*)
from tbl_member; -- 204

-------------------------------------------------------------------------------------------
-- ==================================상품관련====================================
--------------------------------------------------------------------------------------------
/*
   카테고리 테이블명 : tbl_category 

   컬럼정의 
     -- 카테고리 대분류 번호  : 시퀀스(seq_category_cnum)로 증가함.(Primary Key)
     -- 카테고리 코드(unique) : ex) 전자제품  '100000'
                                  의류      '200000'
                                  도서      '300000' 
     -- 카테고리명(not null)  : 전자제품, 의류, 도서           
  
*/ 

--- 카테고리 테이블 생성 

-- drop table tbl_category purge; 
create table tbl_category
(cnum    number(8)     not null  -- 카테고리 대분류 번호
,code    varchar2(20)  not null  -- 카테고리 코드
,cname   varchar2(100) not null  -- 카테고리명
,constraint PK_tbl_category_cnum primary key(cnum)
,constraint UQ_tbl_category_code unique(code)
);

-- 카테고리 시퀀스 생성

-- drop sequence seq_category_cnum;
create sequence seq_category_cnum 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select cnum, code, cname
from tbl_category
order by cnum asc;

-- 스펙 테이블 생성
-- drop table tbl_spec purge;
create table tbl_spec
(snum    number(8)     not null  -- 스펙번호       
,sname   varchar2(100) not null  -- 스펙명         
,constraint PK_tbl_spec_snum primary key(snum)
,constraint UQ_tbl_spec_sname unique(sname)
);

-- 스펙 시퀀스 생성
-- drop sequence seq_spec_snum;
create sequence seq_spec_snum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


---- *** 제품 테이블 : tbl_product *** ----
-- drop table tbl_product purge; 
create table tbl_product
(pnum           number(8) not null       -- 제품번호(Primary Key)
,pname          varchar2(100) not null   -- 제품명
,fk_cnum        number(8)                -- 카테고리코드(Foreign Key)의 시퀀스번호 참조
,pcompany       varchar2(50)             -- 제조회사명
,pimage1        varchar2(100) default 'noimage.png' -- 제품이미지1   이미지파일명
,pimage2        varchar2(100) default 'noimage.png' -- 제품이미지2   이미지파일명 
,pqty           number(8) default 0      -- 제품 재고량
,price          number(8) default 0      -- 제품 정가
,saleprice      number(8) default 0      -- 제품 판매가(할인해서 팔 것이므로)
,fk_snum        number(8)                -- 'HIT', 'NEW', 'BEST' 에 대한 스펙번호인 시퀀스번호를 참조
,pcontent       varchar2(4000)           -- 제품설명  varchar2는 varchar2(4000) 최대값이므로
                                         --          4000 byte 를 초과하는 경우 clob 를 사용한다.
                                         --          clob 는 최대 4GB 까지 지원한다.
                                         
,point          number(8) default 0      -- 포인트 점수                                         
,pinputdate     date default sysdate     -- 제품입고일자
,constraint  PK_tbl_product_pnum primary key(pnum)
,constraint  FK_tbl_product_fk_cnum foreign key(fk_cnum) references tbl_category(cnum)
,constraint  FK_tbl_product_fk_snum foreign key(fk_snum) references tbl_spec(snum)
);

-- drop sequence seq_tbl_product_pnum;
create sequence seq_tbl_product_pnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 제품추가이미지 테이블 생성
create table tbl_addImage
(addImageNo                      number        not null   -- 이미지번호
, addImageName              varchar2(1000)             --이미지파일명
, fk_pnum                       number(8)          not null -- 제품번호
,constraint  FK_tbl_addImage_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);

-- 구매후기 리뷰 테이블 생성
create table tbl_review
(reviewNo                      number             not null   -- 리뷰작성번호
, reviewSubject              varchar2(1000)      not null  -- 리뷰내용
,fk_pnum                        number(8)          not null -- 제품번호
,fk_userid                      varchar2(40)                   --관리자/회원 둘중 한명이 적을것이기 때문에 not null값을 주지않음
,reviewRegisterday          date                 default sysdate   -- 작성일자
, constraint PK_tbl_review_reviewNo primary key(reviewNo)
 ,constraint  FK_tbl_review_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
 ,constraint  FK_tbl_review_fk_userid foreign key(fk_userid) references tbl_member(userid)
); 

--리뷰작성번호 시퀀스 생성
-- drop sequence seq_tbl_coment_no;
create sequence seq_tbl_review_reviewNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-------------------------------------------------------------------------------------------
-- ==================================주문관련====================================
--------------------------------------------------------------------------------------------
-- 주문테이블 생성
create table tbl_order (
    orderCode     varchar2(50) not null -- 주문코드
    ,fk_userid      varchar2(50) not null -- 회원아이디
    ,totalPrice      number       not null -- 주문총액
    ,totalPoint   varchar2(20)                -- 주문총포인트
    ,orderDate   Date         default sysdate   -- 주문일자
   ,constraint  PK_tbl_order_orderCode primary key(orderCode)
   ,constraint  FK_tbl_order_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- 주문상세 테이블 생성
create table tbl_order_details (
    odNo                                number        not null -- 주문상세일련번호
    ,fk_orderCode                    varchar2(50)  not null -- 주문코드
    ,fk_pnum                            number(8)   not null -- 제품번호
    ,odAmount                         number       not null -- 주문량
    ,odPrice                             number        not null -- 주문가격
    ,deliveryCon                      varchar2(50)               -- 배송상태
    ,deliveryDone                       DATE                      -- 배송완료일자
     ,constraint  PK_tbl_order_details_odNo primary key(odNo)
    ,constraint  FK_tbl_order_details_fk_orderCode foreign key(fk_orderCode) references tbl_order(orderCode)
    ,constraint  FK_tbl_order_details_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);


-- 배송지정보 테이블 생성
create table tbl_delivery ( --receiver 을 rec 로 표현
fk_orderCode         varchar2(50)          -- 주문코드
,recMobile             varchar2(200)            -- 연락처 (AES-256 암호화/복호화 대상) 
,recPostcode           varchar2(5)              -- 우편번호
,recAddress            varchar2(200)            -- 주소
,recDetailaddress      varchar2(200)            -- 상세주소
,recExtraaddress       varchar2(200)            -- 참고항목
,dvMessage              varchar2(200)              -- 배송메세지
    ,constraint  FK_tbl_delivery_fk_orderCode foreign key(fk_orderCode) references tbl_order(orderCode)
);

-- 장바구니테이블 생성
create table tbl_cart (
    cartNo          number      not null -- 장바구니번호
    ,fk_userid      varchar2(50) not null -- 회원아이디
    ,fk_pnum      number(8)   not null -- 제품번호
    ,odAmount    number       not null -- 주문량
    ,cartDate        Date         default sysdate   -- 입력일자
   ,constraint  PK_tbl_cart_cartNo primary key(cartNo)
   ,constraint  FK_tbl_cart_fk_userid foreign key(fk_userid) references tbl_member(userid)
   ,constraint  FK_tbl_cart_details_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);

-------------------------------------------------------------------------------------------
-- ==================================게시판관련====================================
--------------------------------------------------------------------------------------------

--공지사항 게시판 테이블 생성
create table tbl_noticeBoard  
(ctNo                                      number              not null          -- 공지사항글번호
,ctTitle                                    varchar2(2000)    not null  -- 공지사항글제목  
,ctContent                               varchar2(4000)  -- 공지사항글내용   
,fk_adId                                   varchar2(40)       not null   -- 글쓴이의 ID  (관리자 아이디)
,ctRegisterday                          date                 default sysdate           -- 작성일자
,ctViewcount                            number(10)        default 0     -- 조회수       

,constraint PK_tbl_noticeBoard_ctNo primary key(ctNo)
,constraint  FK_tbl_noticeBoard_fk_adId foreign key(fk_adId) references tbl_admin(adId)
);

-- 공지사항 글번호 시퀀스 생성
-- drop sequence seq_tbl_noticeBoard_ctNo;
create sequence seq_tbl_noticeBoard_ctNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


--Q&A 게시판 테이블 생성
create table tbl_qaBoard  
(qaNo                                       number           not null          -- Q&A글번호
,qaTitle                                    varchar2(2000)    not null          -- Q&A글제목  
,qaContent                               varchar2(4000)                         -- Q&A글내용   
,qaPwd                                      varchar2(200)      not null        -- Q&A 글 비밀번호
,fk_userid                                  varchar2(40)       not null         -- 글쓴이의 ID (회원아이디)
,qaRegisterday                          date                 default sysdate   -- 작성일자
,qaViewcount                            number(10)        default 0          -- 조회수       


,constraint PK_tbl_qaBoard_qaNo primary key(qaNo)
,constraint  FK_tbl_qaBoard_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Q&A 게시판 글번호 시퀀스 생성
-- drop sequence seq_tbl_qaBoard_qaNo;
create sequence seq_tbl_qaBoard_qaNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

----댓글 테이블 생성
create table tbl_coment
(addno                           number                         -- 댓글번호
, addSubject                         varchar2(1000)     not null -- 댓글내용
, fk_qaNo                        number           not null -- 본글(qa글 번호)
, fk_userid                      varchar2(40)                   --관리자/회원 둘중 한명이 적을것이기 때문에 not null값을 주지않음
, fk_adId                         varchar2(40) 
,addRegisterday               date                 default sysdate   -- 작성일자
, constraint PK_tbl_coment_addno primary key(addno)
, constraint PK_tbl_coment_fk_qaNo foreign key(fk_qaNo) references tbl_qaBoard(qaNo) on delete cascade -- 본글이 지워지면 자동으로 댓글도 삭제
);

--댓글번호 시퀀스 생성
-- drop sequence seq_tbl_coment_no;
create sequence seq_tbl_coment_no
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_product;
