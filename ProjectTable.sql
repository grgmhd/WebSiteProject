drop table Model2Board;
create table Model2Board(
    idx number primary key,--�Ϸù�ȣ
    id varchar2(30) not null,
    --name varchar2(50) not null,--�ۼ��ڸ�
    --email varchar2(50) not null,
    title varchar2(300) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--÷�������� �������ϸ�
    sfile varchar2(30),--������ ���� ����� ���ϸ�
    --pass varchar2(50) not null,--��й�ȣ(����,�������� Ȯ���� ���� ���)
    visitcount number default 0 not null, --�Խù� ��ȸ��
    boardName varchar2(30)
    );
    
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_prtBoard_idx.nextval,'test','�ڷ�� ����1�Դϴ�.','����', 'not');
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_prtBoard_idx.nextval,'test','�ڷ�� ����2�Դϴ�.','����', 'not');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test','�ڷ�� ����3�Դϴ�.','����3', 'not');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test2','�ڷ�� ����4�Դϴ�.','����4', 'not');
insert into Model2Board(idx, id, title, content, boardName )
    values(seq_prtBoard_idx.nextval,'test2','�ڷ�� ����1�Դϴ�.','����', 'fre');
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_prtBoard_idx.nextval,'test2','�ڷ�� ����2�Դϴ�.','����', 'fre');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test1','�ڷ�� ����3�Դϴ�.','����3', 'fre');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test2','�ڷ�� ����4�Դϴ�.','����4', 'fre');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test5','�ڷ�� ����5�Դϴ�.','����5', 'fre');

SELECT B.*, M.name
  			   FROM Model2Board B INNER JOIN Projectmember M 
  			   ON B.id = M.id
  			   WHERE idx=2 ;

drop table Projectmember;
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
insert into Projectmember(id, pass, name ,mobile, address) values ('test', '1234', '�׽�Ʈ','01000000000','����� ���ﱸ �����20�� �������Ʈ');
insert into Projectmember(id, pass, name ,mobile, address) values ('test2', '1234', '�׽�Ʈ','01000000000','����� ���ﱸ �����20�� �������Ʈ');

drop table pboard;

ALTER TABLE Model2Board
	ADD CONSTRAINT pBoard_mem_fk
	FOREIGN KEY (id)
	REFERENCES Projectmember (id)
;

alter table PROJECTMEMBER DROP CONSTRAINT SYS_C007639;

select * from user_constraints;

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

/*
--���� ����
drop table mdl1brd;
create table mdl1brd(
    idx number primary key,--�Ϸù�ȣ
    id varchar2(30) not null, --member
    email varchar2(50) not null, 
    title varchar2(200) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--÷�������� �������ϸ�
    sfile varchar2(30),--������ ���� ����� ���ϸ�
    pass varchar2(50) not null,--��й�ȣ(����,�������� Ȯ���� ���� ���)
    visitcount number default 0 not null--�Խù� ��ȸ��
    );
    
create sequence seq_mdl1brd_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

insert into mdl1brd(idx, id, email, title, content, pass)
    values(seq_mdl1brd_idx.nextval,'kim','babo@naver.com','�ڷ�� ����1�Դϴ�.','����','1234');
insert into mdl1brd(idx, id , email, title, content, pass)
    values(seq_mdl1brd_idx.nextval,'kim2','bapo@naver.com','�ڷ�� ����2�Դϴ�.','����','1234');
    
select Tb.*, rownum rNum from(
    select*from mdl1brd order by idx desc) Tb; */

commit;

