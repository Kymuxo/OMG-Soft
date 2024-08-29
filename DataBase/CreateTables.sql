--drop table ORDERS 
--drop table WORKERS
--drop table ADMINS
--drop table PRODUCTS
--drop table SERVICESS
--drop table HELP
--drop table CONSULTATION
--drop table CUSTOMERS
--drop table OFFICES


use ITEnvironment;
------------�������� � ���������� ������� OFFICES
create table OFFICES 
(  
	OFFICES nvarchar(50) constraint 
	OFFICES_NAME primary key,
	OFFICES_TOWN  nvarchar(50),  
) 
insert into OFFICES   (OFFICES, OFFICES_TOWN)        values ('��.������', '�����');
insert into OFFICES   (OFFICES, OFFICES_TOWN)         values ('��.���������','�����');
insert into OFFICES   (OFFICES, OFFICES_TOWN)         values ('��-� �������������','������');
insert into OFFICES   (OFFICES, OFFICES_TOWN)          values  ('��.����������','������');
insert into OFFICES   (OFFICES, OFFICES_TOWN)        values  ('��.���������','�����');
insert into OFFICES   (OFFICES, OFFICES_TOWN)        values ('��-� ��������', '�����');

------------�������� � ���������� ������� SERVICESS 
create table SERVICESS 
(  
	SERVICESS nvarchar(50) constraint 
	SERVICESS_TYPE primary key,
	SERVICESS_PRICE  float,  
	SERVICESS_AMT int,
    SERVICESS_SPECIALITY  varchar(50)
) 
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('IT-����������', 6, 3, 'IT-����������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('�������� ���',15, 2, '��������� �������������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('������������ ����',9, 4, '���������� �� �������������� ������������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('��������� ��',12, 2, '��������� �����������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('����������� ����',7, 0, '������� �������������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('IP-���������', 10, 1, '��������� �����������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('�����������', 56, 2, '��������� �����������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('��������� Windows', 34, 0, '��������� �����������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('��������� ��������', 19, 0, '��������� �����������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('��������� ����������', 10, 0, '��������� �����������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('��������� ��������� ����������', 61, 0, '��������� �����������');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('���������� �������� ��� �����', 56, 0, '�������-�����������');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('3D ������������� � ��������', 56, 0, 'Wed-��������');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('���������� ������', 56, 0, '�������-�����������');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('������ ����������������� �������', 56, 0, 'Wed-��������');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('�� �������', 0, 0, '');
-------------�������� � ���������� ������� PRODUCTS
 create table PRODUCTS 
(  
	PRODUCTS nvarchar(50) constraint 
	PRODUCTS_NAME primary key,
	PRODUCTS_COST  int,  
    PRODUCTS_AMT int,
	OFFICES nvarchar(50) constraint PRODUCTS_IN_OFFICE foreign key
	references OFFICES(OFFICES)
) 
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('������� �������', 25, 4, '��.���������');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('�������������', 10, 2, '��.���������');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('����', 15, 3, '��.���������');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('�����', 24, 3, '��-� ��������');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('������', 18, 2, '��-� ��������');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('�� �������', 0, 0, '��-� ��������');
-------------�������� � ���������� ������� WORKERS 
 create table WORKERS 
(  
	WORKERS nvarchar(20) constraint 
	WORKERS_SURNAME primary key,
	WORKERS_NAME  nvarchar(20), 
	WORKERS_PASSWORD nvarchar(20),
    SERVICESS nvarchar(50) constraint WORKERS_SPECIALITY foreign key   
	references SERVICESS(SERVICESS),
	OFFICES nvarchar(50) constraint WORKERS_IN_OFFICE foreign key
	references OFFICES(OFFICES),
	WORKERS_YEARS int,
	WORKERS_CONTACTS nvarchar(100)
) 
																															--IT-����������
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','���������','vorvb89','IT-����������', '��-� ��������', 6,'+375(44)584-65-98');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�����','��������','3g8o3fb','IT-����������', '��-� ��������', 2,'+375(44)756-65-78');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','����','onv38gv','IT-����������', '��-� ��������', 6,'+375(44)167-75-92');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','������','vb379bw3','��������� ����������', '��-� ��������', 6,'+375(44)746-94-77');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�����������','����','367bv2','��������� ����������', '��-� ��������', 1,'375(44)825-67-09, 375(33)908-51-38');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','����������','7rnox2nf8','�����������', '��-� ��������', 5,'375(44)825-67-09, 375(33)908-51-38');
																															 --������� �������������
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�������','�����','37hnx32n9n','��������� ����������', '��.����������', 3,'olgaAstr@gmail.ru, 375(29)141-96-11');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�������','������','39m7xn74','IP-���������', '��.����������', 2,'andrew_polgmail.ru, 375(29)756-54-98');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('����','���a','73nnwdne','IP-���������', '��.����������', 3,'olgaAstr@gmail.ru, 375(29)123-72-73');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','�����','n48nv88or','IP-���������', '��.����������', 3,'olgaAstr@gmail.ru, 375(44)837-45-38');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','���������','73nmhxn7','��������� ��������� ����������', '��.����������', 3,'olgaAstr@gmail.ru, 375(29)502-83-54');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('���������','�����','ke94hslwn8f','�����������', '��-� ��������', 5,'375(44)825-67-09, 375(33)908-85-38');
																															--IP-���������
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('����������','����������','78nxfnh','��������� Windows', '��-� ��������', 5,'375(44)825-67-09, 375(33)483-77-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','�����','6xbnbg983h','��������� Windows', '��-� ��������', 8,'375(44)825-67-09, 375(33)427-95-34');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('����������','����������','73fdnxm3h7','��������� Windows', '��-� ��������', 5,'375(44)825-67-09, 375(44)908-27-00');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','�������','84nb48hv','��������� ��������� ����������', '��-� ��������', 1,'375(44)825-67-09, 375(33)005-57-04');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','�����','r8gi4hhwf','������������ ����', '��-� ��������', 5,'375(44)825-67-09, 375(33)452-834-43');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','��������','hn4vb78pb','������������ ����', '��-� ��������', 4,'375(44)825-67-09, 375(44)908-78-27');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�����������','�������','80n0wn0ipk','������������ ����', '��-� ��������', 5,'375(44)825-67-09, 375(33)538-75-35');
																															--���������� �� �������������� ������������
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','�����','7npw3bx','��������� ��������� ����������','��.������',  7,'pavel.sistemprogrammer@inbox.ru, 375(44)264-47-22');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�������','�������','9mh9epm','���������� �������� ��� �����','��.������',  8,'evgen.sistemprogrammer@inbox.ru, 375(29)645-12-77');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������������','�����','98mnphctpm8','���������� �������� ��� �����','��.������',  7,'pavels.sistempogrammer@inbox.ru, 375(29)652-78-01');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','�������','98ummh9chmc','���������� �������� ��� �����','��.������',  2,'lera.sistemprogrammer@inbox.ru, 375(29)923-46-27');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�����','�������','mx9i2nocd','��������� ��','��.������',  7,'evg.sistemprogrammer@inbox.ru, 375(29)378-12-96');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','���������','0mnvbwea','��������� ��','��.������',  1,'vlad.sistemprogrammer@inbox.ru, 375(29)534-77-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�������','�����','2l37b9boa','��������� ��������','��.������',  9,'slva.sistemprogrammer@inbox.ru, 375(44)652-94-24');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�������','���������','pnc4pwehm','��������� ��������','��.������',  7,'slavic.sistemprogrammer@inbox.ru, 375(29)248-76-03');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','���������','9nbobuwuf','��������� ��������','��.������',  3,'slavvv.sistemprogrammer@inbox.ru, 375(29)889-14-30');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','������','aq2wcka','�����������','��.������',  7,'andrew.sistemprogrammer@inbox.ru, 375(44)745-98-70');
																															 --��������� �����������
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�����','�������','8hnnp3bf','�������� ���', '��.���������', 4,'375(29)337-34-79');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','�����','000picwx','�������� ���', '��.���������', 5,'375(33)687-123-22');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('����������','����','894fnopjsp','�������� ���', '��.���������', 10,'375(33)245-86-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�������','�������','mocmw9','�������� ���', '��.���������', 4,'375(44)438-14-67');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�����','�����','7hg9oewblso','�������� ���', '��.���������', 6,'375(33)357-74-44');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('���������','�����','08tbwbge6','����������� ����', '��.���������', 2,'375(33)255-74-72');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�����','������','83bo2xc3i4g','����������� ����', '��.���������', 4,'375(33)731-45-62');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('������','�������','973obufl','����������� ����', '��.���������', 3,'375(29)538-19-75');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�����1','�������1','989hxhurj','����������� ����', '��.���������', 4,'375(33)412-78-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('��������','���������','2hcko8w8idh','����������� ����', '��.���������', 8,'375(33)245-76-73');
																															 --��������� �������������
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('�� ���������','','','�� �������','��-� ��������',0,'');
------------�������� � ���������� ������� CUSTOMERS 
create table CUSTOMERS
(  
	CUSTOMERS nvarchar(50) constraint 
	CUSTOMERS_LOGIN primary key,
	CUSTOMERS_PASSWORD nvarchar(20),
	CUSTOMERS_SURNAME  nvarchar(20), 
	CUSTOMERS_NAME  nvarchar(20), 
	CUSTOMERS_CART nvarchar(20),
	CUSTOMERS_CONTACTS nvarchar(100),
	CUSTOMERS_LANGUAGE int DEFAULT 0,
	CUSTOMERS_THEME int DEFAULT 0,
	CUSTOMERS_PHOTO image DEFAULT 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
) 

  
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Georg1986@mail.ru','drbgliur7','�������','�������', '285632846934', 'Georg1986@mail.ru, +375-(29)-277-03-42', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('katerina@gmail.ru','nru4e9ha','������','���������', '736926493675', '+375-(29)-762-00-41', 0, 1, 0xFFD8FFE000104A46494600010101006000600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('AndreykaXXX@inbox.ru','tbcobu547','��������','������', '01701298365695', '+375-(44)-583-38-35', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('KseniyaSinitsa@mail.ru','cbawi4u4','��������','������', '097397326587401', '+375-(29)-942-43-72', 1, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('AwerinAl@mail.ru','4acozcbrk','������','�������', '9369264027401', '+375-(29)-287-28-45', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Bashalex@mail.ru','3xnogr','���','�������', '379640154854', '+375-(44)-644-57-97', 0, 1, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('vlesovToni@mail.ru','47n4ceo','������','�����', '9634972632', '+375-(29)-548-10-97', 0, 1, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('zagashevg@mail.ru','cc46gbsis','��������','�������', '32749647364', '+375-(29)-767-77-27', 1, 1, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('ZuttoNaZutto@mail.ru','gco47ncih','�����','���������', '3649264923', '+375-(29)-453-78-24', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('ilushenko@mail.ru','4t7cyon74y','���������','������', '0324729685320', '+375-(29)-284-97-27', 0, 1, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Vodemka@mail.ru','oc3mpuar','������','�����', '36492470496', '+375-(29)-765-39-01', 1, 0, 0xFFD8FFE000104A46494600010100000100010000FFFE003C43524541544F523A2067642D6A7065672076312E3020287573696E6720494A47204A50454720763632292C207175616C697479203D203130300AFFDB0043000101010101010101010101010101010101010101010101010101010101010101010101010101010101);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Nagushevdimik@mail.ru','c3hg7nhnr','�������','�������', '3541684632485', '+375-(29)-823-52-01', 1, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A); 
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Onilshak@mail.ru','4cgoe8nc','����','������', '52727867', '+375-(44)-579-42-07', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('KseniyaSinitsa1@mail.ru','hrgrhgni8','��������1','������1', '7652786782', '+375-(29)-467-39-27', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
------------�������� � ���������� ������� ADMINS 
create table ADMINS
(  
	ADMINS nvarchar(50) constraint 
	ADMINS_LOGIN primary key,
	ADMINS_PASSWORD nvarchar(20),
	ADMINS_SURNAME  nvarchar(20), 
	ADMINS_PATRONYMIC  nvarchar(20), 
	ADMINS_NAME  nvarchar(20), 
	ADMINS_CONTACTS nvarchar(100),
	PRODUCTS nvarchar(50) constraint ADMINS_IN_PRODUCTS foreign key
	references PRODUCTS(PRODUCTS),
) 

  
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('AduenkoAl@mail.ru','83mn8uCW','�������','����������','��������������', '+375-(44)-279-45-01');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('BelodedEvgen@gmail.ru','n9jdn9','�������','�������','�������������', '+375-(29)-915-26-97');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('Varban2000@inbox.ru','u99hewhviy','������','������','�����������', '+375-(44)-615-61-49');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('OleinicKir@mail.ru','8c2ojob','�������','������','����������', '+375-(29)-315-00-85');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('MirAndSlava@inbox.com','Taxi88005553535','�������','��������','�����������', '+375-(39)-676-01-25');
------------�������� � ���������� ������� ORDERS 
create table ORDERS
(  
	ORDERS int identity(0,1) constraint 
	ORDERS_ID primary key,
	SERVICESS nvarchar(50) constraint ORDERS_SERVICESS_TYPE foreign key
	references SERVICESS(SERVICESS),
	PRODUCTS nvarchar(50) constraint ORDERS_PRODUCTS_TYPE foreign key
	references PRODUCTS(PRODUCTS),
	ORDERS_DATE  date, 
	ORDERS_WORKER nvarchar(20), -- ����� ����� �� ��������� ������������� ��� ������ ��� ����� ������� ���� 
    ORDERS_COST int,
	CUSTOMERS nvarchar(50) constraint ORDERS_OFCUSTOMERS foreign key
	references CUSTOMERS(CUSTOMERS), 
	ORDERS_ADRES nvarchar(100),
) 
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('������������ ����','������', '2019-5-8','��������',  10, 'katerina@gmail.ru', '��. ������� �.143 ��.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('�������� ���','�������������', '2019-7-17','�����', 10, 'KseniyaSinitsa@mail.ru', '��-� ������������� �.45 ��.105');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('�������� ���','����', '2019-7-17','�����', 10, 'KseniyaSinitsa@mail.ru', '��-� ������������� �.45 ��.105');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('��������� ��','������� �������', '2019-6-25','�������', 5, 'ZuttoNaZutto@mail.ru', '��. ������� �.46 ��.15');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('IT-����������','�����', '2019-5-30','���� ��� �����������', 5, 'AndreykaXXX@inbox.ru', '��. ���������� �.7 ��.33');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('IT-����������','�����', '2019-5-30','���� ��� �����������', 5, 'AndreykaXXX@inbox.ru', '��. ���������� �.7 ��.33');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('IT-����������','������� �������', '2019-5-30','���� ��� �����������', 5, 'AndreykaXXX@inbox.ru', '��. ���������� �.7 ��.33');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('������������ ����','�������������', '2019-5-8','��������',  10, 'katerina@gmail.ru', '��. ������� �.143 ��.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('������������ ����','������� �������', '2019-5-8','��������',  10, 'katerina@gmail.ru', '��. ������� �.143 ��.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('�����������','������', '2019-5-8','��������',  10, 'katerina@gmail.ru', '��. ������� �.143 ��.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('IP-���������','������� �������', '2019-5-8','��������',  10, 'katerina@gmail.ru', '��. ������� �.143 ��.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('��������� ��','����', '2019-5-8','��������',  10, 'katerina@gmail.ru', '��. ������� �.143 ��.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('�����������','�����', '2019-5-8','��������',  10, 'katerina@gmail.ru', '��. ������� �.143 ��.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('������������ ����','����', '2019-5-8','��������',  10, 'katerina@gmail.ru', '��. ������� �.143 ��.12');

create table HELP
(
	QUESTION nvarchar(200) constraint
	QUESTION_ID primary key,
	ANSWER nvarchar(3000)
)
insert into HELP (QUESTION, ANSWER) values (
'���� �� � ��� �����? ����� ���������� �����?', 
'�� ���� ������� ����������� ��������� � ����������� ����������. 
������ ��������� ����� ���� ���������� � �������� � �� ������ �����������. 
� ��� ��� ������� ������. �� � ���� ������ �����������, ���� ���� ��� � 
�������� �� ����. ������� ����������� ������������ � ������ ������ � 
����������� �������� � ��������� ���������� �������������� �������� 
��������. ��������� ��������� ��������� ����� ���� �� 2014 ���. ��� ���� 
��������� � ���� ������ ������� �� ����������� � ��������� ���������. 
�������� ���������� �������, ��� �� ��� ����� �� ��������� ������ 
���������� � ������� ���������� �� ����������. � ���� �� ���������? ��� 
������� ������� ����� ������� � ����� ��������? ��� ������ ������������� 
����� ���������, �� ���� ������ ������ ���� ��������� � ���������� �����. 
���� � ������������� ������� �������� ������ � ����� ���������� 
�����������. �� ������ ������� �������� �������� ��������� ������ 
������������� ����������. ����������� ������� � ������ ���������, �� �� 
���� ������ ������ ���� ����: ��� ����������, ���� � � �������� ������.');
insert into HELP (QUESTION, ANSWER) values (
'������� ���� ��������������. � ��� ���� ������������ � ���������� ����?',
'�������� � ���������� ��-��������������. ���� �� ������� �������� 
�������� ��������� � ��-�������� ����� ����� �������� ���� � ���� � 
������ � ����� ���� �������. ����� ����� �������� �������, ��� 
����������� ��� ���� ��� ����������� �������� ������� �������� � ���� 
��� �����������. ���� ���� ��� �������� � ����� ��� ��������, ������ 
�������, �� ���� ��������� ������������. ���� ����� ��������, ��� 
�������� ���� �������? ��� �������������� ��������, � �� ��� ������.
������ ��� ����� ������������? ����� ������ ������ ��������� �� 
��-�������������� �������� � ��� ��� ��������. ��������� � ����������� 
��������� �������� ������� ������� ������������ � ���� ������������ � 
���������������� ������. ���������� ��������� ��������� ����� ���������� 
��������� ������������ ��� ���������� � ������������, � ������ �������� 
��-����������� ������� ����� � ���� ����. ������ ��� ����� ���� 
���������, �� ��� ������� ��������.');
insert into HELP (QUESTION, ANSWER) values (
'����� � ��� ��-������ �� ��������� ���? ������ ������ ����� �����?',
'������ � ����������� ������� ������ � ���� ����������� ���������������� 
������������. �������������� �������� ����� �����, ������� �����. ���� 
��� � ���, ��� ����� ����� ������ ���������� ������� ����� ������� � 
�����. �� ������, ��� ��� ������������� ������ ��������, � ������ ����� 
���� ��� � � ���� � ����� ��������� ������ �������, ����� ������ �� � 
��� �����. ��� ���� ������ �������� �� �� ������� � ���� ���������, ��� 
��� �� ��� ������. � ����� �������� ������ ��� ������, ����� 
������������� �������� 5 ��� ������ �� ��������� ���. �������� ����� 
�������� (��������� �� �������), �������� ����������� �� ����� �������, 
������ ����� ������� ��������� � ��� �����. ����� ��������� ������ 
����������, ��� �������� �� ����� ������. ���� ���� ����� ��-��������. 
��� ����� ������ ��������� �������������. ����, � ����� �� ������ � 
�������, ��������� ������������� ������ ������������ � ���������� ������ 
�����. ��� ��� �����������, ������������ ���� �� ����������� � 
������������ � ��. ��� ������, ������ � 5 ���. ���. ����� ����������� �� 
����. ����� ������ ������� ��������� ����� ������� ��������. ���� 
����������� ���� ��� � ��������� ������� ������, �������� ���������������� 
��-�����. � ����������� ������� ��� ��������� ����������� �������. ����� 
������ ���������� ��������� ��������, � �� �������������� �������� � 
��������� �������. ������� ������� ��� ������������ �������.');
insert into HELP (QUESTION, ANSWER) values (
'� ��������� ����� windows, ���������� �����. ���� ������� ���������� 
����� �����, ����. ���������� ���������� ����� ��������� ����� �������� 
��� �����?',
'��� ������ ���������� Recuva � ������������� � ������� ���������. 
R-Studio 8.10 Build 173857 � ������, �� �����, Handy Recovery � ������ 
� ������');
insert into HELP (QUESTION, ANSWER) values (
'����� ���� ��������� ���������� �� � �����������? 
����� ������������ ����� ��������?',
'���������� �������� � ����������� � ���� �� �������� �������� 
����������������� ���� ��-��������������. ��������� ��������� 
������������� ����� ��������� � ��������� ����������� � ������� ������ 
������� ��������. ������������ ���� ����� ������ ���������, �� �� ����� 
�����, � �� ����� � � ������������ ������. ������, �������������, 
������� ������� ������������, ������� ���������� � ��� ��� ����� ������, 
��� � ������ ������� �����������.');
insert into HELP (QUESTION, ANSWER) values (
'��� �� ������ � ��������������� ��? ��� ��������� ��������?',
'������������� ����� ����� ��������� �������� ���������� ��������� ��. 
��� ��� �����: �� ����� ������ �����������, ����������� ������ (������ 
��������� ����� ����� ����� ������), ����� ������������ � ������ ��� 
���������� � ��������������. �� ������ �������� ��������, � ����� 
�������� �������� ��������. ����� ��������� ��������� � ��������� ���� 
��� ��������. �������� �� ���� ����, ��� �������, ������������ ��������. 
��������� ������������� ������ ��������� ����������� ��� ����� � �����. 
���������� ������������� �������������� � ��� ������. � ��������� ������ 
� ��������������� �������������.');
insert into HELP (QUESTION, ANSWER) values (
'���� ����������� �� ������������ �� � ��������? ��� ����� 
�������������� � ��������?',
'�� ������ ������ ����� ���������� ��������������� ������������ � 
��������� ��-��������������. �� ������� ����� �����, ��� ������ ����� 
���-�� �������� � ����������������. ������������ �����, �������������� 
������������ �������, ������������� � ����� �������� ��� �������������� 
��������� �������� � ������ � �������� ������ ��������������, ��� �� 
����� ����������? ��� ����� �������� ��-������? � ������������ �������, 
�������.');
insert into HELP (QUESTION, ANSWER) values (
'��� ����� �� ��� ��������� ������? ��� ������ ���������� ��������� ��� 
������? ����� ������� ������������� �� ��������� � ��������� �����?',
'����������� ������ �� �� ������ �������� ������ ������������ �� 
�������� :) ��� � ������������ � ������� ����� ������ ����������. �� 
��� � ������ ����� � ����� ����������, ��� ������� � ��� �����������. 
���� �� ������������ �������� ��� �������� ������-������������ � 
������������ � ��������� ��� ��-������ ���������� ������ �� ��������� 
������, ������ ������� �����, ������ �� �����������. ����� �����, ����� 
����� ����� �������� ��� ��� � ����. ����� ��-����� ������ ���, ��� ����� 
������ ����� � � ��� ��� �����. ��� ��� ���������� �������� ����� ������. 
�������� �� ������: �������� ����� � ������� ������ �� ����� �����, ��� 
�������� ����. ��� ���������, ��������������, ����������������. 
������������ ������������ � ������� �������. ����� ������ ����� ����� � 
�������� �������� �������������. �� � ����� ��� ���������� ������ ������� 
�� ������, � � ����� ������ �� ����� ���������, ��� ��������� ������ �� 
�����. ��� �������� ��������, ����� ������� ��������, ��� ��������� 
�������. � � ������ ���� �������. ��������� ������� ������ �� ������������� 
������ ������� ��� ���������� ������ � ����������� ������ � �������� ����� 
��������� �������� �������������.');
insert into HELP (QUESTION, ANSWER) values (
'����� ������� HDD �������?',
'��� ��������� ����� ����������� �������� ���������� (�������� ����.�����, 
������.���� � �.�.). ���� ��������� ��������� � ���� ����������� 
�������������� ���������� ����������, ���� ���� ��� � ���.
� HDD ����������� ����� ��� 2�� ��� 4��, �� 3�� �� ������� ������.
��������:
SEAGATE Expansion Portable STEA2000400 (2��) ��� STEA4000400 (4��)
WD Elements Portable WDBU6Y0020BBK-WESN (2��)
WD My Passport WDBUAX0040BBK-EEUE (4��)');

create table CONSULTATION
(
CONSULTATION int identity(0,1) constraint 
CONSULTATION_ID primary key,
CUSTOMERS nvarchar(50) constraint ORDERS_CONSULTATION foreign key
references CUSTOMERS(CUSTOMERS),
CONSULTATION_DATE date, 
OFFICES nvarchar(50) constraint CONSULTATION_IN_OFFICE foreign key
references OFFICES(OFFICES),
)

insert into CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) values('Georg1986@mail.ru', '2019-5-8', '��.������');
insert into CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) values('zagashevg@mail.ru', '2019-5-8', '��.����������');
insert into CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) values('KseniyaSinitsa1@mail.ru', '2019-5-8', '��.������');
insert into CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) values('Bashalex@mail.ru', '2019-5-8', '��-� �������������');