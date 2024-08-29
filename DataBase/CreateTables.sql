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
------------Создание и заполнение таблицы OFFICES
create table OFFICES 
(  
	OFFICES nvarchar(50) constraint 
	OFFICES_NAME primary key,
	OFFICES_TOWN  nvarchar(50),  
) 
insert into OFFICES   (OFFICES, OFFICES_TOWN)        values ('ул.Ленина', 'Минск');
insert into OFFICES   (OFFICES, OFFICES_TOWN)         values ('ул.Свердлова','Минск');
insert into OFFICES   (OFFICES, OFFICES_TOWN)         values ('пр-т Независимости','Могилёв');
insert into OFFICES   (OFFICES, OFFICES_TOWN)          values  ('ул.Московская','Гродно');
insert into OFFICES   (OFFICES, OFFICES_TOWN)        values  ('ул.Карбышева','Минск');
insert into OFFICES   (OFFICES, OFFICES_TOWN)        values ('пр-т Жирикова', 'Брест');

------------Создание и заполнение таблицы SERVICESS 
create table SERVICESS 
(  
	SERVICESS nvarchar(50) constraint 
	SERVICESS_TYPE primary key,
	SERVICESS_PRICE  float,  
	SERVICESS_AMT int,
    SERVICESS_SPECIALITY  varchar(50)
) 
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('IT-аутсорсинг', 6, 3, 'IT-аутсорсинг');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Создание ЛВС',15, 2, 'Системный администратор');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Безопасность сети',9, 4, 'Специалист по информационной безопасности');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Поддержка ПО',12, 2, 'Системный программист');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Оптимизация сети',7, 0, 'Сетевой администратор');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('IP-телефония', 10, 1, 'Системный программист');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Диагностика', 56, 2, 'Системный программист');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Установка Windows', 34, 0, 'Системный программист');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Установка программ', 19, 0, 'Системный программист');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Установка антивируса', 10, 0, 'Системный программист');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Удаленная настройка компьютера', 61, 0, 'Системный программист');--
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Разработка проектов под заказ', 56, 0, 'Инденер-программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('3D моделирование и анимация', 56, 0, 'Wed-дизайнер');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Наполнение сайтов', 56, 0, 'Инденер-программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Услуги проффесионального дизайна', 56, 0, 'Wed-дизайнер');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY )        values ('Не выбрано', 0, 0, '');
-------------Создание и заполнение таблицы PRODUCTS
 create table PRODUCTS 
(  
	PRODUCTS nvarchar(50) constraint 
	PRODUCTS_NAME primary key,
	PRODUCTS_COST  int,  
    PRODUCTS_AMT int,
	OFFICES nvarchar(50) constraint PRODUCTS_IN_OFFICE foreign key
	references OFFICES(OFFICES)
) 
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('Сетевой адаптер', 25, 4, 'ул.Карбышева');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('Маршрутизатор', 10, 2, 'ул.Карбышева');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('Мост', 15, 3, 'ул.Карбышева');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('Короб', 24, 3, 'пр-т Жирикова');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('Кабель', 18, 2, 'пр-т Жирикова');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES)        values ('Не выбрано', 0, 0, 'пр-т Жирикова');
-------------Создание и заполнение таблицы WORKERS 
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
																															--IT-аутсорсинг
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Королёв','Александр','vorvb89','IT-аутсорсинг', 'пр-т Жирикова', 6,'+375(44)584-65-98');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Хомич','Владимир','3g8o3fb','IT-аутсорсинг', 'пр-т Жирикова', 2,'+375(44)756-65-78');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Степанов','Иван','onv38gv','IT-аутсорсинг', 'пр-т Жирикова', 6,'+375(44)167-75-92');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Лягута','Максим','vb379bw3','Установка антивируса', 'пр-т Жирикова', 6,'+375(44)746-94-77');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Березовская','Юлия','367bv2','Установка антивируса', 'пр-т Жирикова', 1,'375(44)825-67-09, 375(33)908-51-38');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Богданов','Константин','7rnox2nf8','Диагностика', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)908-51-38');
																															 --Сетевой администратор
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Астрова','Ольга','37hnx32n9n','Установка антивируса', 'ул.Московская', 3,'olgaAstr@gmail.ru, 375(29)141-96-11');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Поляков','Андрей','39m7xn74','IP-телефония', 'ул.Московская', 2,'andrew_polgmail.ru, 375(29)756-54-98');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Буко','Аллa','73nnwdne','IP-телефония', 'ул.Московская', 3,'olgaAstr@gmail.ru, 375(29)123-72-73');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Астахова','Ольга','n48nv88or','IP-телефония', 'ул.Московская', 3,'olgaAstr@gmail.ru, 375(44)837-45-38');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Шрубиков','Александр','73nmhxn7','Удаленная настройка компьютера', 'ул.Московская', 3,'olgaAstr@gmail.ru, 375(29)502-83-54');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Арестенок','Ольга','ke94hslwn8f','Диагностика', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)908-85-38');
																															--IP-телефония
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Богданович','Константин','78nxfnh','Установка Windows', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)483-77-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Киселева','Дарья','6xbnbg983h','Установка Windows', 'пр-т Жирикова', 8,'375(44)825-67-09, 375(33)427-95-34');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Козловский','Константин','73fdnxm3h7','Установка Windows', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(44)908-27-00');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Лапина','Евгения','84nb48hv','Удаленная настройка компьютера', 'пр-т Жирикова', 1,'375(44)825-67-09, 375(33)005-57-04');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Богдан','Павел','r8gi4hhwf','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)452-834-43');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Алимов','Григорий','hn4vb78pb','Безопасность сети', 'пр-т Жирикова', 4,'375(44)825-67-09, 375(44)908-78-27');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Вельковская','Валерия','80n0wn0ipk','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)538-75-35');
																															--Специалист по информационной безопасности
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Марченко','Павел','7npw3bx','Удаленная настройка компьютера','ул.Ленина',  7,'pavel.sistemprogrammer@inbox.ru, 375(44)264-47-22');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Горовой','Евгений','9mh9epm','Разработка проектов под заказ','ул.Ленина',  8,'evgen.sistemprogrammer@inbox.ru, 375(29)645-12-77');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Громаковский','Павел','98mnphctpm8','Разработка проектов под заказ','ул.Ленина',  7,'pavels.sistempogrammer@inbox.ru, 375(29)652-78-01');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Кузьмина','Валерия','98ummh9chmc','Разработка проектов под заказ','ул.Ленина',  2,'lera.sistemprogrammer@inbox.ru, 375(29)923-46-27');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Гуцев','Евгений','mx9i2nocd','Поддержка ПО','ул.Ленина',  7,'evg.sistemprogrammer@inbox.ru, 375(29)378-12-96');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Липень','Владислав','0mnvbwea','Поддержка ПО','ул.Ленина',  1,'vlad.sistemprogrammer@inbox.ru, 375(29)534-77-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Малеева','Алина','2l37b9boa','Установка программ','ул.Ленина',  9,'slva.sistemprogrammer@inbox.ru, 375(44)652-94-24');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Омелько','Станислав','pnc4pwehm','Установка программ','ул.Ленина',  7,'slavic.sistemprogrammer@inbox.ru, 375(29)248-76-03');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Петров','Станислав','9nbobuwuf','Установка программ','ул.Ленина',  3,'slavvv.sistemprogrammer@inbox.ru, 375(29)889-14-30');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Прищеп','Андрей','aq2wcka','Диагностика','ул.Ленина',  7,'andrew.sistemprogrammer@inbox.ru, 375(44)745-98-70');
																															 --Системный программист
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Быков','Алексей','8hnnp3bf','Создание ЛВС', 'ул.Карбышева', 4,'375(29)337-34-79');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Русецкий','Вадим','000picwx','Создание ЛВС', 'ул.Карбышева', 5,'375(33)687-123-22');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Сенаторова','Анна','894fnopjsp','Создание ЛВС', 'ул.Карбышева', 10,'375(33)245-86-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Соколов','Арсений','mocmw9','Создание ЛВС', 'ул.Карбышева', 4,'375(44)438-14-67');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Таран','Софья','7hg9oewblso','Создание ЛВС', 'ул.Карбышева', 6,'375(33)357-74-44');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Филипович','Павел','08tbwbge6','Оптимизация сети', 'ул.Карбышева', 2,'375(33)255-74-72');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Чобот','Виктор','83bo2xc3i4g','Оптимизация сети', 'ул.Карбышева', 4,'375(33)731-45-62');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Шарков','Алексей','973obufl','Оптимизация сети', 'ул.Карбышева', 3,'375(29)538-19-75');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Быков1','Алексей1','989hxhurj','Оптимизация сети', 'ул.Карбышева', 4,'375(33)412-78-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Ахлебина','Екатерина','2hcko8w8idh','Оптимизация сети', 'ул.Карбышева', 8,'375(33)245-76-73');
																															 --Системный администратор
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Не требуется','','','Не выбрано','пр-т Жирикова',0,'');
------------Создание и заполнение таблицы CUSTOMERS 
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

  
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Georg1986@mail.ru','drbgliur7','Абрамов','Георгий', '285632846934', 'Georg1986@mail.ru, +375-(29)-277-03-42', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('katerina@gmail.ru','nru4e9ha','Каропа','Екатерина', '736926493675', '+375-(29)-762-00-41', 0, 1, 0xFFD8FFE000104A46494600010101006000600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('AndreykaXXX@inbox.ru','tbcobu547','Васильев','Андрей', '01701298365695', '+375-(44)-583-38-35', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('KseniyaSinitsa@mail.ru','cbawi4u4','Синицына','Ксения', '097397326587401', '+375-(29)-942-43-72', 1, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('AwerinAl@mail.ru','4acozcbrk','Аверин','Алексей', '9369264027401', '+375-(29)-287-28-45', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Bashalex@mail.ru','3xnogr','Баш','Алексей', '379640154854', '+375-(44)-644-57-97', 0, 1, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('vlesovToni@mail.ru','47n4ceo','Власов','Антон', '9634972632', '+375-(29)-548-10-97', 0, 1, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('zagashevg@mail.ru','cc46gbsis','Загацкий','Евгений', '32749647364', '+375-(29)-767-77-27', 1, 1, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('ZuttoNaZutto@mail.ru','gco47ncih','Зутто','Анастасия', '3649264923', '+375-(29)-453-78-24', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('ilushenko@mail.ru','4t7cyon74y','Ильющенко','Максим', '0324729685320', '+375-(29)-284-97-27', 0, 1, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Vodemka@mail.ru','oc3mpuar','Каптюг','Вадим', '36492470496', '+375-(29)-765-39-01', 1, 0, 0xFFD8FFE000104A46494600010100000100010000FFFE003C43524541544F523A2067642D6A7065672076312E3020287573696E6720494A47204A50454720763632292C207175616C697479203D203130300AFFDB0043000101010101010101010101010101010101010101010101010101010101010101010101010101010101);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Nagushevdimik@mail.ru','c3hg7nhnr','Нагушев','Дмитрий', '3541684632485', '+375-(29)-823-52-01', 1, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A); 
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('Onilshak@mail.ru','4cgoe8nc','Онил','Ксения', '52727867', '+375-(44)-579-42-07', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE, CUSTOMERS_THEME, CUSTOMERS_PHOTO)        values ('KseniyaSinitsa1@mail.ru','hrgrhgni8','Синицына1','Ксения1', '7652786782', '+375-(29)-467-39-27', 0, 0, 0xFFD8FFE000104A46494600010101004800480000FFDB0043000403030403030404030405040405060A07060606060D090A080A0F0D10100F0D0F0E11131814111217120E0F151C151719191B1B1B10141D1F1D1A1F181A1B1AFFDB0043010405050605060C07070C1A110F111A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A);
------------Создание и заполнение таблицы ADMINS 
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

  
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('AduenkoAl@mail.ru','83mn8uCW','Адуенко','Александра','Константиновна', '+375-(44)-279-45-01');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('BelodedEvgen@gmail.ru','n9jdn9','Белодед','Евгений','Александрович', '+375-(29)-915-26-97');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('Varban2000@inbox.ru','u99hewhviy','Варбан','Ульяна','Геннадьевна', '+375-(44)-615-61-49');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('OleinicKir@mail.ru','8c2ojob','Олейник','Кирилл','Васильевич', '+375-(29)-315-00-85');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_PATRONYMIC, ADMINS_CONTACTS)        values ('MirAndSlava@inbox.com','Taxi88005553535','Бондарь','Мирослав','Анатольевич', '+375-(39)-676-01-25');
------------Создание и заполнение таблицы ORDERS 
create table ORDERS
(  
	ORDERS int identity(0,1) constraint 
	ORDERS_ID primary key,
	SERVICESS nvarchar(50) constraint ORDERS_SERVICESS_TYPE foreign key
	references SERVICESS(SERVICESS),
	PRODUCTS nvarchar(50) constraint ORDERS_PRODUCTS_TYPE foreign key
	references PRODUCTS(PRODUCTS),
	ORDERS_DATE  date, 
	ORDERS_WORKER nvarchar(20), -- нужно брать из работникв специализацию как запрос или через внешний ключ 
    ORDERS_COST int,
	CUSTOMERS nvarchar(50) constraint ORDERS_OFCUSTOMERS foreign key
	references CUSTOMERS(CUSTOMERS), 
	ORDERS_ADRES nvarchar(100),
) 
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Безопасность сети','Кабель', '2019-5-8','Богданов',  10, 'katerina@gmail.ru', 'ул. Семашко д.143 кв.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Создание ЛВС','Маршрутизатор', '2019-7-17','Быков', 10, 'KseniyaSinitsa@mail.ru', 'пр-т Независимости д.45 кв.105');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Создание ЛВС','Мост', '2019-7-17','Быков', 10, 'KseniyaSinitsa@mail.ru', 'пр-т Независимости д.45 кв.105');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Поддержка ПО','Сетевой адаптер', '2019-6-25','Маченко', 5, 'ZuttoNaZutto@mail.ru', 'ул. Громова д.46 кв.15');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('IT-аутсорсинг','Короб', '2019-5-30','Пока нет специалиста', 5, 'AndreykaXXX@inbox.ru', 'ул. Молодежная д.7 кв.33');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('IT-аутсорсинг','Короб', '2019-5-30','Пока нет специалиста', 5, 'AndreykaXXX@inbox.ru', 'ул. Молодежная д.7 кв.33');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('IT-аутсорсинг','Сетевой адаптер', '2019-5-30','Пока нет специалиста', 5, 'AndreykaXXX@inbox.ru', 'ул. Молодежная д.7 кв.33');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Безопасность сети','Маршрутизатор', '2019-5-8','Богданов',  10, 'katerina@gmail.ru', 'ул. Семашко д.143 кв.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Безопасность сети','Сетевой адаптер', '2019-5-8','Богданов',  10, 'katerina@gmail.ru', 'ул. Семашко д.143 кв.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Диагностика','Кабель', '2019-5-8','Богданов',  10, 'katerina@gmail.ru', 'ул. Семашко д.143 кв.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('IP-телефония','Сетевой адаптер', '2019-5-8','Богданов',  10, 'katerina@gmail.ru', 'ул. Семашко д.143 кв.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Поддержка ПО','Мост', '2019-5-8','Богданов',  10, 'katerina@gmail.ru', 'ул. Семашко д.143 кв.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Диагностика','Короб', '2019-5-8','Богданов',  10, 'katerina@gmail.ru', 'ул. Семашко д.143 кв.12');
insert into ORDERS   (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES)        values ('Безопасность сети','Мост', '2019-5-8','Богданов',  10, 'katerina@gmail.ru', 'ул. Семашко д.143 кв.12');

create table HELP
(
	QUESTION nvarchar(200) constraint
	QUESTION_ID primary key,
	ANSWER nvarchar(3000)
)
insert into HELP (QUESTION, ANSWER) values (
'Есть ли у нас бэкап? Можно посмотреть отчет?', 
'На этом вопросе затруднения возникают у большинства айтишников. 
Делать резервные копии всей информации в компании — их прямая обязанность. 
И они как правило делают. Но — либо делают неправильно, либо один раз и 
забывают об этом. Недавно специалисты «Информатика и Сервис» пришли в 
юридическую компанию и попросили системного администратора показать 
«бэкапы». Последняя найденная резервная копия была за 2014 год. Три года 
документы и базы данных бизнеса не сохранялись в резервное хранилище. 
Компании невероятно повезло, что за это время не произошло ничего 
критичного и деловая информация не пострадала. А если бы произошло? Как 
заранее оценить риски бизнеса в такой ситуации? Для многих руководителей 
будет сюрпризом, но план бэкапа должен быть составлен в письменной форме. 
Речь о распечатанном перечне хранимых данных и плане резервного 
копирования. По любому запросу директор получает подробный список 
скопированной информации. Технические термины в отчете допустимы, но по 
этой бумаге должно быть ясно: что копируется, куда и в скольких копиях.');
insert into HELP (QUESTION, ANSWER) values (
'Опишите нашу инфраструктуру. У нас есть документация в письменном виде?',
'Сисадмин — архитектор ИТ-инфраструктуры. Если на просьбу показать 
описание структуры и ИТ-ресурсов админ гордо отвечает «она у меня в 
голове» — время бить тревогу. Очень часто айтишник считает, что 
расписывать все узлы его гениального творения простым смертным — ниже 
его достоинства. Даже если все работает и админ все понимает, бизнес 
рискует, не имея подробной документации. Если админ уволится, как 
передать дела другому? Это инфраструктура компании, а не его личная.
Почему так важна документация? Можно всегда быстро взглянуть на 
ИТ-инфраструктуру компании — как она устроена. Понимание и способность 
объяснить простыми словами систему руководителю — тест адекватности и 
профессионализма админа. Прозрачная структура позволяет проще привлекать 
сторонних специалистов для расширения и модернизации, а новому штатному 
ИТ-специалисту быстрее войти в курс дела. Админу это может быть 
невыгодно, но это выгодно компании.');
insert into HELP (QUESTION, ANSWER) values (
'Какой у нас ИТ-бюджет на следующий год? Почему именно такая сумма?',
'Бюджет — традиционно больной вопрос в силу технической некомпетентности 
руководителя. Администраторы называют любые суммы, которые могут. Дело 
тут в том, что часто админ мыслит категорией «купить самое дорогое и 
новое». Он уверен, что так гарантировано решает проблему, а заодно тешит 
свое эго — у него в фирме последняя модель сервера, самое нужное ПО и 
так далее. При этом деньги компании он не считает — есть убеждение, что 
это не его работа. В нашей практике аудита был случай, когда 
администратор запросил 5 млн рублей на следующий год. Докупить новых 
серверов (мощностей не хватает), заменить коммутаторы на более дорогие, 
купить новое сетевое хранилище и так далее. После глубокого аудита 
выяснилось, что покупать не нужно НИЧЕГО. Даже есть запас ИТ-ресурсов. 
Ими нужно просто правильно распорядиться. Итак, в ответ на вопрос о 
бюджете, системный администратор должен спланировать и обосновать каждую 
цифру. Это его обязанность, руководитель ведь не разбирается в 
оборудовании и ПО. Как видите, бюджет с 5 млн. руб. может сократиться до 
нуля. Админ должен разумно экономить любые ресурсы компании. Если 
обоснования цифр нет — подождите тратить деньги, закажите профессиональный 
ИТ-аудит. В большинстве случаев это обойдется значительно дешевле. Админ 
всегда предпочтет нарастить мощности, а не оптимизировать процессы и 
сократить расходы. Поэтому просите его обосновывать затраты.');
insert into HELP (QUESTION, ANSWER) values (
'Я установил новый windows, формировал диски. Хочу вернуть потерянные 
файлы видео, фото. Подскажите пожалуйста какая программа лучше подходит 
для этого?',
'Для начала попробуйте Recuva — универсальная и удобная программа. 
R-Studio 8.10 Build 173857 — сложно, но мощно, Handy Recovery — просто 
и удобно');
insert into HELP (QUESTION, ANSWER) values (
'Когда были последние обновления ПО и антивирусов? 
Какое оборудование нужно заменить?',
'Обновление программ и антивирусов — один из ключевых моментов 
работоспособности всей ИТ-инфраструктуры. Грамотный системный 
администратор легко расскажет о последних обновлениях и покажет график 
будущих апдейтов. Оборудование тоже нужно менять регулярно, но не одним 
махом, а по плану и с обоснованием затрат. Старое, неэффективное, 
слишком дорогое оборудование, дорогие расходники — все это кухня админа, 
ему и искать способы оптимизации.');
insert into HELP (QUESTION, ANSWER) values (
'Все ли хорошо с лицензированием ПО? Нет пиратских программ?',
'Администратор очень часто поддается соблазну установить пиратское ПО. 
Ему это проще: не нужно искать руководство, «пробивать» бюджет (многие 
программы стоят сотни тысяч рублей), ждать согласований и лишний раз 
беседовать с пользователями. Он ставит «пиратку временно», а потом 
забывает оформить лицензию. Любая пиратская программа — серьезный риск 
для компании. Отвечает за этот риск, как правило, руководитель компании. 
Системный администратор должен объяснять руководству эту мысль и риски. 
Аккуратное своевременное лицензирование — его задача. А нарушения закона 
— ответственность руководителей.');
insert into HELP (QUESTION, ANSWER) values (
'Ваши предложения по модернизации ИТ в компании? Что можно 
оптимизировать и улучшить?',
'На местах админы редко занимаются систематической оптимизацией и 
развитием ИТ-инфраструктуры. Но хороший админ знает, что всегда можно 
что-то улучшить и автоматизировать. Предупредить риски, минимизировать 
операционные расходы, подготовиться к росту компании или оптимизировать 
критичные процессы в кризис — спросите вашего администратора, что он 
может предложить? Как видит развитие ИТ-систем? С обоснованием бюджета, 
конечно.');
insert into HELP (QUESTION, ANSWER) values (
'Ваш отчет за два прошедших месяца? Чем будете заниматься следующие два 
месяца? Какие запросы пользователей вы выполняли в последнее время?',
'Ежедневного отчета ни от одного штатного админа руководители не 
получают :) Нам в «Информатике и Сервисе» такие случаи неизвестны. Но 
раз в неделю можно и нужно спрашивать, что сделано и что планируется. 
Если вы руководитель компании или крупного бизнес-департамента — 
запрашивайте у сисадмина или ИТ-службы письменные отчеты за последние 
месяцы, список текущих задач, задачи на перспективу. Важно знать, какой 
объем работ делается изо дня в день. Часто ИТ-отдел делает вид, что очень 
сильно занят и у них все горит. Так они показывают важность своей работы. 
Поразите их фразой: «хороший админ в штатном режиме не занят ничем, все 
работает само». Все настроено, оптимизировано, автоматизировано. 
Лихорадочная деятельность — признак проблем. Также админы часто тонут в 
рутинных запросах пользователей. Но в отчет они устранение мелких проблем 
не вносят, и в конце недели не могут вспомнить, что конкретно делали по 
часам. Тут драйвера поставил, здесь телефон проверил, там антивирус 
обновил. А в отчете одна строчка. Внедрение системы заявок от пользователей 
станет основой для подробного отчета о проделанной работе и позволит вести 
аналитику запросов пользователей.');
insert into HELP (QUESTION, ANSWER) values (
'Какой внешний HDD выбрать?',
'Для резервных копий рекомендуем облачные технологии (например гугл.драйв, 
яндекс.диск и т.п.). Гугл позволяет загружать в свои фотоальбомы 
неограниченное количество фотографий, если речь идёт о них.
А HDD рекомендуем брать или 2Тб или 4ТБ, на 3Тб не ходовой размер.
Варианты:
SEAGATE Expansion Portable STEA2000400 (2Тб) или STEA4000400 (4Тб)
WD Elements Portable WDBU6Y0020BBK-WESN (2Тб)
WD My Passport WDBUAX0040BBK-EEUE (4Тб)');

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

insert into CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) values('Georg1986@mail.ru', '2019-5-8', 'ул.Ленина');
insert into CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) values('zagashevg@mail.ru', '2019-5-8', 'ул.Московская');
insert into CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) values('KseniyaSinitsa1@mail.ru', '2019-5-8', 'ул.Ленина');
insert into CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) values('Bashalex@mail.ru', '2019-5-8', 'пр-т Независимости');