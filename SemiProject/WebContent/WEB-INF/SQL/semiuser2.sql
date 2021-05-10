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
(adId           varchar2(40)   not null  -- 회원아이디
,adPwd          varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,adName         varchar2(30)   not null  -- 회원명
,adEmail        varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,adMobile       varchar2(200)            -- 연락처 (AES-256 암호화/복호화 대상) 
,constraint PK_tbl_member_userid primary key(adId)
--,constraint UQ_tbl_member_email  unique(email)-- 이메일은 같은 회사이메일을 사용한다는 조건이 있을 수 도 있음?
);

-- footer에 (관리자모드)추가 ->관리자로그인->  카트를 없애고 관리자등록/제품등록 세부메뉴 공지사항글쓰기

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
--Table TBL_CATEGORY이(가) 생성되었습니다

insert into tbl_category (cnum, code, cname) values(seq_category_cnum.nextval, 10000, '침실가구');
insert into tbl_category (cnum, code, cname) values(seq_category_cnum.nextval, 20000, '거실가구');
insert into tbl_category (cnum, code, cname) values(seq_category_cnum.nextval, 30000, '주방가구');
insert into tbl_category (cnum, code, cname) values(seq_category_cnum.nextval, 40000, '드레스룸');
commit;


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


-- 카테고리 세분류 테이블 생성
create table tbl_detailCategory
(fk_cnum    number(8)     not null  -- 카테고리 대분류 번호를 참조
,decode     varchar2(20)  not null  -- 카테고리 세분류 코드
,dename     varchar2(100) not null  -- 카테고리 세분류 명

,constraint UQ_tbl_detailCategory_decode unique(decode)
,constraint  FK_tbl_detailCategory_fk_cnum foreign key(fk_cnum) references tbl_category(cnum)
);
-- 시퀀스 없음
--Table TBL_DETAILCATEGORY이(가) 생성되었습니다.

insert into tbl_detailCategory (fk_cnum, decode, dename) values(1, 10001, '침구');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(1, 10002, '매트리스');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(1, 10003, '침대프레임');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(1, 10004, '커텐');
commit;

insert into tbl_detailCategory (fk_cnum, decode, dename) values(2, 20001, '소파');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(2, 20002, '테이블');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(2, 20003, '장식장');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(2, 20004, '카펫');

insert into tbl_detailCategory (fk_cnum, decode, dename) values(3, 30001, '식탁');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(3, 30002, '선반');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(3, 30003, '조리도구');

insert into tbl_detailCategory (fk_cnum, decode, dename) values(4, 40001, '행거');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(4, 40002, '화장대');
insert into tbl_detailCategory (fk_cnum, decode, dename) values(4, 40003, '거울');

commit;

select cnum, code, cname
from tbl_category
order by cnum asc;

select *
from tbl_spec;

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
--------------------------------------------------------------------------------------------------
insert into tbl_spec (snum, sname) values(seq_spec_snum.nextval, 'NORMAL');
COMMIT;
-- best
-- hit
-- new 
-- normal
---------------------------------------------------------------------------------------------------

---- *** 제품 테이블 : tbl_product *** ----
-- drop table tbl_product purge; 
create table tbl_product
(pnum           number(8) not null       -- 제품번호(Primary Key)
,pname          varchar2(100) not null   -- 제품명
,fk_decode      varchar2(20)             -- 카테고리 세분류 코드 참조
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
,constraint  FK_tbl_product_fk_decode foreign key(fk_decode) references tbl_detailCategory(decode)
,constraint  FK_tbl_product_fk_snum foreign key(fk_snum) references tbl_spec(snum)
);
--Table TBL_PRODUCT이(가) 생성되었습니다.


-- drop sequence seq_tbl_product_pnum;
create sequence seq_tbl_product_pnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '800폭 테이블', '30001', '일룸', 'furniture_01_01.jpg', 'furniture_01_02.jpg', 10, 300000, 300000, 1, '심플하면서도 따뜻한 감성을 가진 로 테이블', 3000);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'DT GRAND 다이닝 테이블', '30001', '챕터원', 'furniture_02_01.jpg', 'furniture_02_02.jpg', 10, 2900000, 2800000, 3, '초승달 모양에서 영감을 받은 다리와 튼튼한 구조가 어우러진 기능성과 미학적으로 훌륭한 조화를 이루어낸 테이블입니다.', 28000);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '데센토 스페인 세라믹 테이블', '30001', '벤스', 'furniture_03_01.jpg', 'furniture_03_02.jpg', 10, 1199000, 1159000, 3, '수천년 전통을 자랑하는 최고급 스페인산 세라믹 다이닝 테이블', 11500);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '델릭식탁', '30001', '델릭', 'furniture_04_01.jpg', 'furniture_04_02.jpg', 20, 769000, 769000, 1, 'Delicious(맛있는)에서 영감을 얻은 델릭(Delic) 시리즈입니다.', 7600);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'DOPPIO 다이닝 테이블', '30001', '챕터원', 'furniture_05_01.jpg', 'furniture_05_02.jpg', 10, 165000, 165000, 4, '부드러운 곡선 형태의 메탈 다리를 사용하여 복고적이고 모던한 테이블입니다.', 1600);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '뉴 디오 체어', '30001', '벤스', 'furniture_06_01.jpg', 'furniture_06_02.jpg', 40, 118000, 118000, 1, '좌방석 절개라인의 스티치 디자인이 돋보이는 의자입니다.', 1100);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '카티프 1인용 라탄의자', '30001', '피카소가구', 'furniture_07_01.jpg', 'furniture_07_02.jpg', 10, 59000, 50150, 4, '천연라탄이 가진 자연의 아름다움을 살린 카디프암체어입니다.', 500);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '리네 패브릭 체어', '30001', '벤스', 'furniture_08_01.jpg', 'furniture_08_02.jpg', 10, 109000, 109000, 4, '패브릭만이 줄 수 있는 아늑하고 포근한 감성으로 안락한 분위기를 연출하는 리네 체어', 1000);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '모리니 테이블', '30001', '일룸', 'furniture_09_01.jpg', 'furniture_09_02.jpg', 30, 799000, 799000, 3, '독특한 모양의 원목다리가 세련되고 감각적인 분위기를 선사합니다.', 7900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '밀란 8인 식탁', '30001', '벤스', 'furniture_10_01.jpg', 'furniture_10_02.jpg', 100, 769000, 769000, 4, '8인이 사용 가능한 모던한 테이블', 7600);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '벤치 의자', '30001', '일룸', 'furniture_11_01.jpg', 'furniture_11_02.jpg', 40, 290000, 290000, 3, '라운드형 디자인이 특징인 벤치', 2900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '1400폭 테이블', '30001', '일룸', 'furniture_12_01.jpg', 'furniture_12_02.jpg', 50, 429000, 429000, 4, '이탈리아 디자이너 클라우디오 벨리니가 디자인한 모던하고 미니멀한 스타일의 테이블', 4200);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '데센토 스페인 세라믹 테이블(고정형)', '30001', '벤스', 'furniture_13_01.jpg', 'furniture_13_02.jpg', 50, 895000, 895000, 4, '세련되고 모던한 다이닝 공간을 연출하는 고급스러운 테이블', 8900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '아르카 체어', '30001', '벤스', 'furniture_14_01.jpg', 'furniture_14_02.jpg', 30, 174000, 174000, 4, '사용 용도에 따라 다양하게 연출할 수 있는 다용도 체어', 1700);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'DT03 아울 X 테이블', '30001', '챕터원', 'furniture_15_01.jpg', 'furniture_15_02.jpg', 40, 1790000, 1790000, 4, '은은한 올리브그린색의 글락 상판과 월넛 다리의 조화가 멋스러운 테이블', 17900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '엘리어스 대리석 6인 식탁', '30001', '벤스', 'furniture_16_01.jpg', 'furniture_16_02.jpg', 50, 578000, 578000, 4, '깔끔한 화이트색과 독특한 다리 모양의 조화가 멋스러운 고급 테이블', 000);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '올리비아 4인 식탁', '30001', '벤스', 'furniture_17_01.jpg', 'furniture_17_02.jpg', 10, 332000, 332000, 4, '4인이 사용가능한 모던한 식탁', 3300);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '원형테이블 1000폭', '30001', '일룸', 'furniture_18_01.jpg', 'furniture_18_02.jpg', 10, 459000, 459000, 4, '거실이나 주방, 서재 등 사용 용도에 따라 다양하게 연출할 수 있는 다용도 테이블', 000);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'WAVE BENCH', '30001', '챕터원', 'furniture_19_01.jpg', 'furniture_19_02.jpg', 10, 1000000, 1000000, 4, '유기적인 곡선으로 공간에 활력을 줄 벤치입니다.', 1000);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '타이디 수납형 식탁', '30001', '일룸', 'furniture_20_01.jpg', 'furniture_20_02.jpg', 50, 420000, 420000, 4, '넓은 상판과 실용적인 하부 수납이 돋보이는 아일랜드형 식탁입니다.', 4200);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '펠리체 원형 테이블', '30001', '벤스', 'furniture_21_01.jpg', 'furniture_21_02.jpg', 10, 620000, 350000, 4, '오랜 시간 첫느낌 그대로 집에서 만나는 기분 좋은 공간을 연출해주는 테이블입니다.', 000);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '홈바세트', '30001', '일룸', 'furniture_22_01.jpg', 'furniture_22_02.jpg', 10, 490000, 490000, 1, '슬림한 디자인이 돋보이는 바테이블과 바스툴 세트입니다.', 4900);

insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '라탄 해머드 글라스 트롤리', '30002', '자라홈', 'storage_01_01.jpg', 'storage_01_02.jpg', 10, 599000, 599000, 3, '바퀴가 달린 트롤리 또는 카트. 두꺼운 우븐 마감 천연 라탄 소재로 제조한 수공예 디자인', 5900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '메탈 우든 수납 가구', '30002', '자라홈', 'storage_02_01.jpg', 'storage_02_02.jpg', 10, 179000, 179000, 4, '아카시아 목재 선반과 무광 마감 아이언 프레임으로 구성된 디자인', 1700);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'RAVAROR', '30002', '이케아', 'storage_03_01.jpg', 'storage_03_02.jpg', 10, 399000, 399000, 1, '튼튼하고 유행을 타지 않는 미니주방', 3900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '스토리지 가구 우드', '30002', '자라홈', 'storage_04_01.jpg', 'storage_04_02.jpg', 10, 69000, 69000, 3, '베이지 컬러 메탈 바스켓 프레임과 서랍이 매치된 스토리지 유닛', 4900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '스토리지 우드', '30002', '자라홈', 'storage_05_01.jpg', 'storage_05_02.jpg', 10, 199000, 199000, 4, '블랙 컬러 메탈 메쉬 구조에 목재 선반이 매치된 수납 가구', 1900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '가드니아', '30002', '리바트', 'storage_06_01.jpg', 'storage_06_02.jpg', 10, 1059000, 1059000, 4, '세련된 그린색이 풍기는 친화적인 분위기의 주방', 10500);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '내츄럴본키친 상부장 벽걸이 주방수납장', '30002', '포홈', 'storage_07_01.jpg', 'storage_07_02.jpg', 10, 198000, 178000, 1, '브라질 소나무 원목과 무독성 수용성 페인트를 사용한 건강한 수납장', 1700);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '데이아 다기능 주방수납장', '30002', '필웰', 'storage_08_01.jpg', 'storage_08_02.jpg', 10, 179000, 159000, 1, '빛의 움직임을 그대로 표현한 고광택 하이그로시 소재의 수납장', 1500);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '델릭스', '30002', '리바트', 'storage_09_01.jpg', 'storage_09_02.jpg', 10, 1045000, 1045000, 4, '모던하고 젊은 감성으로 나만의 감각적인 스타일에 맞춘 즐거움의 공간', 10400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '클로이 원목 유리도어 수납장', '30002', '포홈', 'storage_10_01.jpg', 'storage_10_02.jpg', 10, 299000, 279000, 4, '내추럴한 컬러의 실용적인 주방 수납장', 2700);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'VEDDINGE', '30002', '이케아', 'storage_11_01.jpg', 'storage_11_02.jpg', 10, 40000, 40000, 3, '주방에 밝고 모던한 감각을 더해주는 부드러운 느낌', 400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'BODBYN', '30002', '이케아', 'storage_12_01.jpg', 'storage_12_02.jpg', 10, 80000, 80000, 4, '프레임과 비스듬한 음각 처리로 입체감을 살린 패널로 독특하고 고전적인 느낌이 돋보입니다.', 800);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'JUTIS', '30002', '이케아', 'storage_13_01.jpg', 'storage_13_02.jpg', 10, 60000, 60000, 3, '25년 품질보증된 믿을만한 제품', 600);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '1000폭 주방수납장(도어형)', '30002', '레마', 'storage_14_01.jpg', 'storage_14_02.jpg', 10, 248000, 248000, 1, '내추럴한 컬러와 감성적인 디자인으로 공간에 따뜻한 느낌을 불어넣어주는 수납장입니다.', 2400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'onion 진저 주방 유리 수납장', '30002', '까사미아', 'storage_15_01.jpg', 'storage_15_02.jpg', 10, 2023000, 182300, 4, '실용성과 디자인을 겸비한 주방가구', 1800);

insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '2단 트레이', '30003', '자라홈', 'tool_01_01.jpg', 'tool_01_02.jpg', 20, 99000, 99000, 3, '목재 손잡이가 달린 래커 마감 아이언 베이지 컬러 다용도 2단 트레이', 900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'GLASS CUP', '30003', '챕터원', 'tool_02_01.jpg', 'tool_02_02.jpg', 20, 40000, 40000, 1, '고급스러운 손잡이와 내추럴한 컬러가 조화를 이루는 컵', 400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '스틸 키친 가위', '30003', '자라홈', 'tool_03_01.jpg', 'tool_03_02.jpg', 20, 55000, 55000, 4, '단조 스테일리스 스틸 주방용 가위', 500);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '계량 스푼', '30003', '자라홈', 'tool_04_01.jpg', 'tool_04_02.jpg', 20, 55000, 55000, 1, '레이저 컷 측정의 목재 계량 스푼 3개 세트', 500);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '골드 톤 메탈 직사각 트레이', '30003', '자라홈', 'tool_05_01.jpg', 'tool_05_02.jpg', 20, 99000, 99000, 4, '서빙용으로 이상적인 골드 톤 메탈릭 가장자리와 직사각형 베이스 디자인의 거울 트레이', 900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '교쿠로 세트', '30003', '챕터원', 'tool_06_01.jpg', 'tool_06_02.jpg', 20, 220000, 220000, 4, '귀여운 크기와 형태가 특징인 1인용 다기세트', 2200);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '스테인리스 스틸 나이프 & 커팅 보드', '30003', '자라홈', 'tool_07_01.jpg', 'tool_07_02.jpg', 20, 99000, 99000, 4, '아카시아 목재와 스테인리스 스틸 소재의 커팅 보드와 나이프', 900);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '내추럴 티컵', '30003', '챕터원', 'tool_08_01.jpg', 'tool_08_02.jpg', 20, 26000, 26000, 4, '구겨진듯한 느낌으로 손맛이 느껴지는 디자인의 티컵', 200);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'BOWL S - YELLOW', '30003', '챕터원', 'tool_09_01.jpg', 'tool_09_02.jpg', 20, 32000, 32000, 4, '핀치(손가락) 자국이 특징인 보울', 300);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노르웨이 커트러리, 샐러드 세트', '30003', '챕터원', 'tool_10_01.jpg', 'tool_10_02.jpg', 20, 122000, 122000, 1, '스테인리스 스틸과 우드 손잡이가 결합되어 스테인리스의 묵직한 두께감과 핸들의 둥글고 긴 디자인이 특징입니다.', 1200);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노르웨이 커트러리, 4PCS 선물세트', '30003', '챕터원', 'tool_11_01.jpg', 'tool_11_02.jpg', 20, 155000, 155000, 3, '스테인리스 스틸과 플라스틱이 결합되어 스테인리스의 묵직한 두께감과 핸들의 둥글고 긴 디자인이 특징입니다.', 1500);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '컬러 브레이드 라운드 대나무 트레이', '30003', '자라홈', 'tool_12_01.jpg', 'tool_12_02.jpg', 20, 45000, 45000, 1, '서빙용으로 인상적인 원형 베이스의 브레이드 마감 대나무 트레이', 400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'MUG CUP - NATURAL', '30003', '챕터원', 'tool_13_01.jpg', 'tool_13_02.jpg', 20, 33000, 33000, 4, '자연스러운 곡선의 손잡이는 그립감이 좋아 실용성과 아름다움을 모두 갖추었습니다.', 300);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '핸들 디테일 메탈 트레이', '30003', '자라홈', 'tool_14_01.jpg', 'tool_14_02.jpg', 20, 32000, 32000, 4, '아카시아 나무 손잡이가 달린 이중 래커 마감 금속 트레이', 300);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '스태커블 믹싱볼', '30003', '자라홈', 'tool_15_01.jpg', 'tool_15_02.jpg', 20, 19000, 19000, 3, '스테인리스 스틸 믹싱볼', 100);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '밥그릇 IVORY', '30003', '챕터원', 'tool_16_01.jpg', 'tool_16_02.jpg', 20, 28000, 28000, 4, '흙이 가진 유기적인 미를 표현한 그릇의 전 부분과 자연스러움을 강조한 유약의 느낌이 도드라진 밥그릇', 00);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '하사미 보울 내추럴', '30003', '챕터원', 'tool_17_01.jpg', 'tool_17_02.jpg', 20, 38000, 38000, 4, '천연의 자기재질과 점토를 일정비율 섞어서 만든 반자기 형태의 제품', 300);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'W CUP SAUCER SET', '30003', '챕터원', 'tool_18_01.jpg', 'tool_18_02.jpg', 20, 75000, 75000, 4, '잔잔한 호수에 생기는 파동의 이미지 형상화한 컵', 700);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'VISION GLASS', '30003', '챕터원', 'tool_19_01.jpg', 'tool_19_02.jpg', 20, 15000, 15000, 1, '100% 유리소재의 친환경적이면서도 뛰어난 선명도를 가진 심플하고 투명한 컵', 100);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '오얏꽃 조각잔 세트', '30003', '챕터원', 'tool_20_01.jpg', 'tool_20_02.jpg', 20, 58000, 58000, 3, '순박하고 순수한 오얏꽃(자두꽃)말을 담은 테이블 웨어', 500);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '플로랄 포슬린 스푼 받침', '30003', '자라홈', 'tool_21_01.jpg', 'tool_21_02.jpg', 20, 19000, 19000, 4, '배색된 림과 플로랄 디테일이 매치된 스푼 받침', 100);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '아카시아 우드 주방 도마', '30003', '자라홈', 'tool_22_01.jpg', 'tool_22_02.jpg', 20, 45000, 45000, 4, '식물성 보호 마감 처리된 아카시아 도마', 400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '주물 법랑 전골 냄비', '30003', '챕터원', 'tool_23_01.jpg', 'tool_23_02.jpg', 20, 40000, 40000, 4, '전골 뿐만 아니라 조림이나 찜, 찌개 등 다양한 용도로 사용할 수 있습니다.', 400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'STIIK 젓가락', '30003', '챕터원', 'tool_24_01.jpg', 'tool_24_02.jpg', 20, 48000, 48000, 3, '현대적인 세련된 라인과 컬러감이 만난 정교한 젓가락', 400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'CLEAR B PLATE', '30003', '챕터원', 'tool_25_01.jpg', 'tool_25_02.jpg', 20, 45000, 45000, 3, '간단한 디저트, 과일 등을 올리기에 용이한 단정하고 깔끔한 플레이트', 400);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '흑유 사각 찬기', '30003', '챕터원', 'tool_26_01.jpg', 'tool_26_02.jpg', 20, 30000, 30000, 4, '직사각형태 안에 낮은 깊이와 굽을 통해 단정함을 더한 그릇', 300);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, 'PORTOFINO 플레이트', '30003', '챕터원', 'tool_27_01.png', 'tool_27_02.png', 20, 28000, 28000, 4, '이탈리아 아름다운 항구 도시 포르토피노에서 영감을 얻어 제작한 낭만적인 그릇', 200);
insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '한지 밥,국공기', '30003', '챕터원', 'tool_28_01.jpg', 'tool_28_02.jpg', 20, 30000, 30000, 1, '한지가 가지고 있는 아름닫고 고급스러운 질감과 흙이 가지고 있는 휘는 특징을 이용해 만든 밥, 국그릇입니다.', 300);

commit;

select *
from user_sequences;

select *
from tbl_product;

-- 제품추가이미지 테이블 생성
-- drop table tbl_addImage purge;
create table tbl_addImage
(addImageNo     number          not null   -- 이미지번호
,addImageName   varchar2(1000)             --이미지파일명
,fk_pnum        number(8)       not null   -- 제품번호
,constraint  FK_tbl_addImage_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);
-- Table TBL_ADDIMAGE이(가) 생성되었습니다.


-- 구매후기 리뷰 테이블 생성
create table tbl_review
(reviewNo           number          not null    -- 리뷰작성번호
,reviewSubject      varchar2(1000)  not null    -- 리뷰내용
,fk_pnum            number(8)       not null    -- 제품번호
,fk_userid          varchar2(40)                --
,reviewRegisterday  date    default sysdate     -- 작성일자
,constraint PK_tbl_review_reviewNo primary key(reviewNo)
,constraint  FK_tbl_review_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
,constraint  FK_tbl_review_fk_userid foreign key(fk_userid) references tbl_member(userid)
); 
--Table TBL_REVIEW이(가) 생성되었습니다.


--리뷰작성번호 시퀀스 생성
-- drop sequence seq_tbl_coment_no;
create sequence seq_tbl_review_reviewNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--equence SEQ_TBL_REVIEW_REVIEWNO이(가) 생성되었습니다.


--------------------------------옵션 ----------------------------------
drop table tbl_option purge;
create table tbl_option
(optionNo       number(8) not null  -- 옵션번호(Primary Key)
,onum           number(8) not null  -- 옵션분류번호
,oname          varchar2(50)        -- 옵션분류명
,fk_pnum        number(8) not null  -- 제품번호
,addPrice       number(8) default 0 -- 추가금액
,oContents      varchar2(4000)      -- 옵션내용
,constraint PK_tbl_option_optionNo primary key(optionNo)
,constraint  FK_tbl_option_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);

drop sequence seq_tbl_option_optionNo;
create sequence seq_tbl_option_optionNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_option;

-- 0번 => 색상
-- 1번 => 크기
-- 2번 => 조립유무

-------------------------------------------------------------------------------------------
-- ==================================주문관련====================================
--------------------------------------------------------------------------------------------
-- 주문테이블 생성
-- drop table tbl_order purge;
create table tbl_order (
orderCode       varchar2(50) not null   -- 주문코드
,fk_userid      varchar2(50) not null   -- 회원아이디
,totalPrice     number       not null   -- 주문총액
,totalPoint     number                  -- 주문총포인트
,orderDate      Date    default sysdate -- 주문일자
,constraint  PK_tbl_order_orderCode primary key(orderCode)
,constraint  FK_tbl_order_fk_userid foreign key(fk_userid) references tbl_member(userid)
);
-- Table TBL_ORDER이(가) 생성되었습니다.


insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint, orderDate) values ('20210222-01', 'jhmin07', 237500 , 340, '21/03/21');
insert into tbl_order_details(odNo, fk_orderCode, fk_pnum, odAmount, odPrice, deliveryCon) values (10000, '20210222-01', 97, 1, 237500, '1');
commit;

insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint, orderDate) values ('20210321-02', 'jhmin07', 250000, 200, '21/03/21');
insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint, orderDate) values ('20210321-03', 'jhmin07', 250000, 200, '21/03/21');



insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint) values ('20210509-06', 'seoia', 220000, 200);
insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint, orderDate) values ('20210321-05', 'seoia', 250000, 200, '21/03/21');
insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint, orderDate) values ('20210131-04', 'seoia', 10000, 100, '21/01/31');
insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint, orderDate) values ('20201231-03', 'seoia', 99000, 100, '20/12/31');
insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint, orderDate) values ('20201120-02', 'seoia', 179000, 100, '20/11/20');
insert into tbl_order(orderCode, fk_userid, totalPrice, totalPoint, orderDate) values ('20201118-01', 'seoia', 139000, 100, '20/11/13');
commit;

select *
from tbl_order;

select A.ordercode, A.fk_userid, A.totalprice, A.totalpoint, to_char(A.orderdate, 'yyyy-mm-dd') AS orderdate, 
       B.fk_pnum, B.odAmount, B.deliveryCon, 
       c.pname, c.pimage1, c.fk_decode
from tbl_order A join tbl_order_details B
on A.orderCode = B.fk_orderCode
join tbl_product C
on B.fk_pnum = C.pnum
where fk_userid = 'jhmin07'
and to_char(orderdate, 'yyyy-mm-dd') between '2020-12-01' and '2021-05-10'
and B.deliveryCon = '1'
order by orderdate desc;

insert into tbl_order_details(odNo, fk_orderCode, fk_pnum, odAmount, odPrice, deliveryCon) values (6, '20210509-06', 16, 1, 139000, '1');
insert into tbl_order_details(odNo, fk_orderCode, fk_pnum, odAmount, odPrice, deliveryCon) values (5, '20210321-05', 6, 1, 250000, '2');
insert into tbl_order_details(odNo, fk_orderCode, fk_pnum, odAmount, odPrice, deliveryCon) values (4, '20210131-04', 2, 1, 10000, '3');
insert into tbl_order_details(odNo, fk_orderCode, fk_pnum, odAmount, odPrice, deliveryCon) values (3, '20201231-03', 12, 2, 198000, '3');
insert into tbl_order_details(odNo, fk_orderCode, fk_pnum, odAmount, odPrice, deliveryCon) values (2, '20201120-02', 11, 1, 179000, '3');
insert into tbl_order_details(odNo, fk_orderCode, fk_pnum, odAmount, odPrice, deliveryCon) values (1, '20201118-01', 8, 4, 556000, '3');
commit;

select *
from tbl_order_details;

select *
from tbl_product;

-- 주문상세 테이블 생성
drop table tbl_order_details purge;
create table tbl_order_details (
odNo            number          not null -- 주문상세일련번호
,fk_orderCode   varchar2(50)    not null -- 주문코드
,fk_pnum        number(8)       not null -- 제품번호
,odAmount       number          not null -- 주문량
,odPrice        number          not null -- 주문가격
,optionContents   varchar(1000)          -- 옵션내역
,deliveryCon    varchar2(50)             -- 배송상태(null : 입금확인, 1 : 배송준비중,  2 : 배송중,  3 : 배송완료)
,deliveryDone   DATE                     -- 배송완료일자
,constraint  PK_tbl_order_details_odNo primary key(odNo)
,constraint  FK_tbl_order_details_fk_odCode foreign key(fk_orderCode) references tbl_order(orderCode)
,constraint  FK_tbl_order_details_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);
-- Table TBL_ORDER_DETAILS이(가) 생성되었습니다.

alter table tbl_order_details add(optionContents varchar(1000));

select *
from tbl_order_details;

-- 배송지정보 테이블 생성
--drop table tbl_delivery purge;
create table tbl_delivery ( --receiver 을 rec 로 표현
fk_orderCode        varchar2(50)    -- 주문코드
,recName            varchar2(50)    -- 수취인
,recMobile          varchar2(200)   -- 연락처 (AES-256 암호화/복호화 대상) 
,recPostcode        varchar2(5)     -- 우편번호
,recAddress         varchar2(200)   -- 주소
,recDetailaddress   varchar2(200)   -- 상세주소
,recExtraaddress    varchar2(200)   -- 참고항목
,dvMessage          varchar2(200)   -- 배송메세지
,constraint  FK_tbl_delivery_fk_odCode foreign key(fk_orderCode) references tbl_order(orderCode)
);
-- Table TBL_DELIVERY이(가) 생성되었습니다.


-- 장바구니테이블 생성
drop table  tbl_cart purge;
create table tbl_cart (
cartNo        number       not null -- 장바구니번호
,fk_userid    varchar2(50) not null -- 회원아이디
,fk_pnum      number(8)    not null -- 제품번호
,odAmount     number       not null -- 주문량
,cartDate     Date         default sysdate   -- 입력일자
,optionNo_es  varchar(200)          -- 옵션이름 ('20,30')
,constraint  PK_tbl_cart_cartNo_t primary key(cartNo)
,constraint  FK_tbl_cart_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint  FK_tbl_cart_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);
--Table TBL_CART이(가) 생성되었습니다.

--장바구니 시퀀스 생성
drop sequence seq_tbl_cart_cartNo;
create sequence seq_tbl_cart_cartNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence SEQ_TBL_CART_CARTNO이(가) 생성되었습니다.


select *
from tbl_product;


insert into tbl_cart (cartNo, fk_userid, fk_pnum, odAmount, cartDate ) 
values(seq_tbl_cart_cartNo.nextval, 'admin1', '4', 1, sysdate);

select *
from tbl_cart;

-------------------------------------------------------------------------------------------
-- ==================================게시판관련====================================
--------------------------------------------------------------------------------------------

--공지사항 게시판 테이블 생성
create table tbl_noticeBoard  
(ctNo               number          not null          -- 공지사항글번호
,ctTitle            varchar2(2000)  not null          -- 공지사항글제목  
,ctContent          varchar2(4000)                    -- 공지사항글내용   
,fk_adId            varchar2(40)    not null          -- 글쓴이의 ID  (관리자 아이디)
,ctRegisterday      date            default sysdate   -- 작성일자
,ctViewcount        number(10)      default 0         -- 조회수 
,constraint PK_tbl_noticeBoard_ctNo primary key(ctNo)
,constraint  FK_tbl_noticeBoard_fk_adId foreign key(fk_adId) references tbl_admin(adId)
);
--생성함
select *
from tbl_noticeBoard;


-- 공지사항 글번호 시퀀스 생성
-- drop sequence seq_tbl_noticeBoard_ctNo;
create sequence seq_tbl_noticeBoard_ctNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--생성함



--Q&A 게시판 테이블 생성
create table tbl_qaBoard  
(qaNo           number           not null         -- Q&A글번호
,qaTitle        varchar2(2000)   not null         -- Q&A글제목  
,qaContent      varchar2(4000)                    -- Q&A글내용   
,qaPwd          varchar2(200)    not null         -- Q&A 글 비밀번호
,fk_userid      varchar2(40)     not null         -- 글쓴이의 ID (회원아이디)
,qaRegisterday  date             default sysdate  -- 작성일자
,qaViewcount    number(10)       default 0        -- 조회수
,constraint PK_tbl_qaBoard_qaNo primary key(qaNo)
,constraint  FK_tbl_qaBoard_fk_userid foreign key(fk_userid) references tbl_member(userid)
);
--생성함

-- Q&A 게시판 글번호 시퀀스 생성
-- drop sequence seq_tbl_qaBoard_qaNo;
create sequence seq_tbl_qaBoard_qaNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--생성함


--댓글 테이블 생성
create table tbl_coment
(addno            number                   -- 댓글번호
,addSubject       varchar2(1000)  not null -- 댓글내용
,fk_qaNo          number          not null -- 본글(qa글 번호)
,writer           varchar2(40)    not null -- userid or adminid
,addRegisterday   date            default sysdate   -- 작성일자
,constraint PK_tbl_coment_addno primary key(addno)
,constraint PK_tbl_coment_fk_qaNo foreign key(fk_qaNo) references tbl_qaBoard(qaNo) on delete cascade -- 본글이 지워지면 자동으로 댓글도 삭제
);
--Table TBL_COMENT이(가) 생성되었습니다.


--댓글번호 시퀀스 생성
-- drop sequence seq_tbl_coment_no;
create sequence seq_tbl_coment_no
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence SEQ_TBL_COMENT_NO이(가) 생성되었습니다.
