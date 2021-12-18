create table Model2Board(
    idx number primary key,--�Ϸù�ȣ
    id varchar2(30) not null,
    name varchar2(50) not null,--�ۼ��ڸ�
    email varchar2(50) not null,
    title varchar2(300) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--÷�������� �������ϸ�
    sfile varchar2(30),--������ ���� ����� ���ϸ�
    pass varchar2(50) not null,--��й�ȣ(����,�������� Ȯ���� ���� ���)
    visitcount number default 0 not null, --�Խù� ��ȸ��
    boardName varchar2(30) not null
    );
insert into Projectboard(idx,id,name,email,title,content,pass)
    values(seq_board_num.nextval,'kim','������','babo@naver.com','�ڷ�� ����1�Դϴ�.','����','1234');
insert into Projectboard(idx,id,name,email,title,content,pass)
    values(seq_board_num.nextval,'kim2','������','bapo@naver.com','�ڷ�� ����2�Դϴ�.','����','1234');
    
create table Projectmember
(
    id varchar2(30) not null,
    pass varchar2(40) not null,
    name varchar2(50) not null,
    regidate date default sysdate,
    tellNum varchar2(30),
    mobile varchar2(30) not null,
    address varchar2(200) not null,
    primary key (id)
);

insert into Projectmember(id,pass, name,mobile,address) values ('test', '1234', '�׽�Ʈ','01000000000','����� ���ﱸ �����20�� �������Ʈ');

ALTER TABLE Model2Board
	ADD CONSTRAINT pBoard_mem_fk
	FOREIGN KEY (id)
	REFERENCES Projectmember (id)
;

create sequence seq_empBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

create sequence seq_prtBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    


commit;