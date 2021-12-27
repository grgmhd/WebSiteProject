#DB 생성
CREATE DATABASE musthave_db;
#계정 생성
CREATE user 'musthave_user'@'localhost' IDENTIFIED BY '1234';
#계정에 DB관련 권한 부여
GRANT ALL PRIVILEGES ON musthave_db.* TO 'musthave_user'@'localhost';
#새로고침
FLUSH PRIVILEGES;

# 일반 게시판 테이블(자식)
create table Model2Board(
	idx INT PRIMARY KEY AUTO_INCREMENT NOT NULL,	#일련번호
	id VARCHAR(30) not null,
	title VARCHAR(300) not null,
	content TEXT not null,
	postdate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ofile varchar(200),		#첨부파일의 원본파일명
	sfile varchar(30),	#서버에 실제 저장된 파일명
	visitcount SMALLINT DEFAULT 0 NOT NULL,	#게시물 조회수
	boardName VARCHAR(30)	#직원 emp, 보호자 prt, 공지 not, 자유fre, 사진 gal, 자료실 ref
);

#회원 테이블(부모)
create table Projectmember
(
	id VARCHAR(30) NOT NULL,
	pass VARCHAR(40) NOT NULL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	regidate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	tellNum VARCHAR(30),
	mobile VARCHAR(30) NOT NULL,
	address TEXT NOT NULL,
	type SMALLINT DEFAULT 2,	#0:관리자 / 1:직원 / 2:일반회원
	PRIMARY KEY (id)
);

#외래키 설정(일반 게시판 테이블 --> 멤버 테이블)
ALTER TABLE Model2Board ADD CONSTRAINT fk_M2Board_pMember
	FOREIGN KEY (id) REFERENCES Projectmember (id);
	
	
#캘린더형 게시판 테이블(자식)
DROP TABLE model2boardcal;
CREATE TABLE Model2BoardCal(
	idx INT PRIMARY KEY AUTO_INCREMENT NOT NULL,	#일련번호
	id VARCHAR(30) NOT NULL,
	title VARCHAR(300) NOT NULL,
	content TEXT NOT NULL,
	pdate DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
	boardName VARCHAR(30)
);


#수아몰 테이블 
create table product(
	idx INT AUTO_INCREMENT NOT NULL,		#상품일련번호
	imgfile VARCHAR(100),	#이미지파일
	pname VARCHAR(50) NOT NULL,	#상품명
	pcontent TEXT NOT NULL,	#상품설명
	price VARCHAR(50) NOT NULL,	#가격
	point VARCHAR(50) NOT NULL,	#적립금
	id VARCHAR(30) NOT null,
	eaNum VARCHAR(50) NOT NULL,	#선택수량
	delivery VARCHAR(50) NOT NULL,	#배송비
	delVer VARCHAR(50) NOT NULL,		#배송구분(무료배송/택배배송/직접배달)
	PRIMARY KEY (idx)
);


#장바구니 
create table basket(
	idx INT AUTO_INCREMENT NOT NULL,	#상품일련번호
	id VARCHAR(30) NOT NULL,
	eaNum INT NOT NULL,	#선택수량
	sump INT NOT NULL,		#합계금액
	primary key (idx)
);

#외래키(장바구니 --> 상품) ※ 에러발생. 수정요망
ALTER TABLE basket
	ADD CONSTRAINT product_basket_fk
	FOREIGN KEY (pNum)
	REFERENCES product (pNum)
;    

#상품 주문서
create table orderl(
	id VARCHAR(30) primary KEY NOT NULL,
	address TEXT NOT NULL,	#배송지
	pay VARCHAR(50) NOT NULL	#결제방법
); 


#외래키(장바구니와 상품주문서) ※ 실행은 잘되지만 확인 요망.
ALTER TABLE basket
	ADD CONSTRAINT basket_orderl_fk
	FOREIGN KEY (id)
	REFERENCES orderl (id)
;musthave_db