--drop table ORDERS 
--drop table CUSTOMERS
--drop table WORKERS
--drop table ADMINS
--drop table PRODUCTS
--drop table SERVICESS
--drop table OFFICES


--use ITEnvironment;
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
    SERVICESS_SPECIALITY  varchar(50)
) 
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('IT-аутсорсинг', 6,'IT-аутсорсинг');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )         values ('Создание ЛВС',15, 'Системный администратор');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )         values ('Безопасность сети',9, 'Специалист по информационной безопасности');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )          values  ('Поддержка ПО',12, 'Системный программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values  ('Оптимизация сети',7, 'Сетевой администратор');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('IP-телефония', 10,'Системный программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('Диагностика', 56,'Системный программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('Установна Windows', 34,'Системный программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('Установна программ', 19,'Системный программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('Установка антивируса', 10,'Системный программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('Удаленная настройка компьютера', 61,'Системный программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('Разработка проектов под заказ', 56,'Инденер-программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('3D моделирование и анимация', 56,'Wed-дизайнер');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('Наполнение сайтов', 56,'Инденер-программист');
insert into SERVICESS   (SERVICESS, SERVICESS_PRICE, SERVICESS_SPECIALITY )        values ('Услуги проффесионального дизайна', 56,'Wed-дизайнер');
-------------Создание и заполнение таблицы PRODUCTS
 create table PRODUCTS 
(  
	PRODUCTS nvarchar(50) constraint 
	PRODUCTS_NAME primary key,
	PRODUCTS_COST  int,  
    PRODUCTS_AMT int,
	OFFICES nvarchar(50) constraint PRODUCTS_IN_OFFICE foreign key
	references OFFICES(OFFICES),
	PRODUCTS_INFO nvarchar(100)
) 
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES, PRODUCTS_INFO )        values ('Сетевой адаптер', 23, 8, 'ул.Карбышева', ' ');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES, PRODUCTS_INFO )        values ('Маршрутизатор', 23, 8, 'ул.Карбышева', ' ');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES, PRODUCTS_INFO )        values ('Мост', 23, 8, 'ул.Карбышева', ' ');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES, PRODUCTS_INFO )        values ('Короб', 23, 8, 'пр-т Жирикова', ' ');
insert into PRODUCTS   (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES, PRODUCTS_INFO )        values ('Кабель', 23, 8, 'пр-т Жирикова', ' ');
-------------Создание и заполнение таблицы WORKERS 
 create table WORKERS 
(  
	WORKERS nvarchar(20) constraint 
	WORKERS_SURNAME primary key,
	WORKERS_NAME  nvarchar(20), 
	WORKERS_PASSWORD nvarchar(20),
    SERVICESS nvarchar(50) constraint WORKERS_SPECIALITY foreign key  --Нужно связать с SERVICESS_SPECIALITY, но это не ключевое поле...? 
	references SERVICESS(SERVICESS),
	OFFICES nvarchar(50) constraint WORKERS_IN_OFFICE foreign key
	references OFFICES(OFFICES),
	WORKERS_YEARS int,
	WORKERS_CONTACTS nvarchar(100)
) 
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Королёв','Александр','vorvb89','Оптимизация сети', 'пр-т Жирикова', 6,'+375(44)584-65-98');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Хомич','Владимир','3g8o3fb','Оптимизация сети', 'пр-т Жирикова', 6,'+375(44)756-65-78');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Степанов','Иван','onv38gv','Оптимизация сети', 'пр-т Жирикова', 6,'+375(44)167-75-92');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Лягута','Максим','vb379bw3','Оптимизация сети', 'пр-т Жирикова', 6,'+375(44)746-94-77');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Березовская','Юлия','367bv2','Оптимизация сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)908-51-38');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Богданов','Константин','7rnox2nf8','Оптимизация сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)908-51-38');
																															  --Сетевой администратор
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Астрова','Ольга','37hnx32n9n','IP-телефония', 'ул.Московская', 3,'olgaAstr@gmail.ru, 375(29)141-96-11');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Поляков','Андрей','39m7xn74','IP-телефония', 'ул.Московская', 3,'andrew_polgmail.ru, 375(29)756-54-98');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Буко','Аллa','73nnwdne','IP-телефония', 'ул.Московская', 3,'olgaAstr@gmail.ru, 375(29)123-72-73');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Астахова','Ольга','n48nv88or','IP-телефония', 'ул.Московская', 3,'olgaAstr@gmail.ru, 375(44)837-45-38');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Шрубиков','Александр','73nmhxn7','IP-телефония', 'ул.Московская', 3,'olgaAstr@gmail.ru, 375(29)502-83-54');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Арестенок','Ольга','ke94hslwn8f','IP-телефония', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)908-85-38');
																														  --IP-телефония
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Богданович','Константин','78nxfnh','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)483-77-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Киселева','Дарья','6xbnbg983h','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)427-95-34');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Козловский','Константин','73fdnxm3h7','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(44)908-27-00');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Лапина','Евгения','84nb48hv','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)005-57-04');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Богдан','Павел','r8gi4hhwf','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)452-834-43');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Алимов','Григорий','hn4vb78pb','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(44)908-78-27');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Вельковская','Валерия','80n0wn0ipk','Безопасность сети', 'пр-т Жирикова', 5,'375(44)825-67-09, 375(33)538-75-35');
																																--Специалист по информационной безопасности
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Марченко','Павел','7npw3bx','Поддержка ПО','ул.Ленина',  7,'pavel.sistemprogrammer@inbox.ru, 375(44)264-47-22');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Горовой','Евгений','9mh9epm','Поддержка ПО','ул.Ленина',  7,'evgen.sistemprogrammer@inbox.ru, 375(29)645-12-77');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Громаковский','Павел','98mnphctpm8','Поддержка ПО','ул.Ленина',  7,'pavels.sistempogrammer@inbox.ru, 375(29)652-78-01');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Кузьмина','Валерия','98ummh9chmc','Поддержка ПО','ул.Ленина',  7,'lera.sistemprogrammer@inbox.ru, 375(29)923-46-27');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Гуцев','Евгений','mx9i2nocd','Поддержка ПО','ул.Ленина',  7,'evg.sistemprogrammer@inbox.ru, 375(29)378-12-96');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Липень','Владислав','0mnvbwea','Поддержка ПО','ул.Ленина',  7,'vlad.sistemprogrammer@inbox.ru, 375(29)534-77-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Малеева','Алина','2l37b9boa','Поддержка ПО','ул.Ленина',  7,'slva.sistemprogrammer@inbox.ru, 375(44)652-94-24');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Омелько','Станислав','pnc4pwehm','Поддержка ПО','ул.Ленина',  7,'slavic.sistemprogrammer@inbox.ru, 375(29)248-76-03');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Петров','Станислав','9nbobuwuf','Поддержка ПО','ул.Ленина',  7,'slavvv.sistemprogrammer@inbox.ru, 375(29)889-14-30');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Прищеп','Андрей','aq2wcka','Поддержка ПО','ул.Ленина',  7,'andrew.sistemprogrammer@inbox.ru, 375(44)745-98-70');
																														   --Системный программист
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Быков','Алексей','8hnnp3bf','Оптимизация сети', 'ул.Карбышева', 4,'375(29)337-34-79');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Русецкий','Вадим','000picwx','Оптимизация сети', 'ул.Карбышева', 4,'375(33)687-123-22');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Сенаторова','Анна','894fnopjsp','Оптимизация сети', 'ул.Карбышева', 4,'375(33)245-86-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Соколов','Арсений','mocmw9','Оптимизация сети', 'ул.Карбышева', 4,'375(44)438-14-67');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Таран','Софья','7hg9oewblso','Оптимизация сети', 'ул.Карбышева', 4,'375(33)357-74-44');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Филипович','Павел','08tbwbge6','Оптимизация сети', 'ул.Карбышева', 4,'375(33)255-74-72');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Чобот','Виктор','83bo2xc3i4g','Оптимизация сети', 'ул.Карбышева', 4,'375(33)731-45-62');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Шарков','Алексей','973obufl','Оптимизация сети', 'ул.Карбышева', 4,'375(29)538-19-75');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Быков1','Алексей1','989hxhurj','Оптимизация сети', 'ул.Карбышева', 4,'375(33)412-78-14');
insert into WORKERS   (WORKERS,  WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS)        values ('Ахлебина','Екатерина','2hcko8w8idh','Оптимизация сети', 'ул.Карбышева', 4,'375(33)245-76-73');
																														  --Системный администратор

------------Создание и заполнение таблицы CUSTOMERS 
create table CUSTOMERS
(  
	CUSTOMERS nvarchar(50) constraint 
	CUSTOMERS_LOGIN primary key,
	CUSTOMERS_PASSWORD nvarchar(20),
	CUSTOMERS_SURNAME  nvarchar(20), 
	CUSTOMERS_NAME  nvarchar(20), 
	CUSTOMERS_CART nvarchar(20),
	CUSTOMERS_CONTACTS nvarchar(100)
) 

  
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('Georg1986@mail.ru','drbgliur7','Abramov','Greg', '285632846934', 'Georg1986@mail.ru, +375-(29)-277-03-42');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('katerina@gmail.ru','nru4e9ha','Каропа','Екатерина', '736926493675', '++375-(29)-762-00-41');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('AndreykaXXX@inbox.ru','tbc; obu547','Васильев','Андрей', '01701298365695', '+375-(44)-583-38-35');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('KseniyaSinitsa@mail.ru','cbawi4u4','Синицына','Ксения', '097397326587401', '+375-(29)-942-43-72');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('AwerinAl@mail.ru','4acozcbrk','Аверин','Алексей', '9369264027401', '+375-(29)-287-28-45');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('Bashalex@mail.ru','3xnogr','Баш','Алексей', '379640154854', '+375-(44)-644-57-97');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('vlesovToni@mail.ru','47n4ceo','Власов','Антон', '9634972632', '+375-(29)-548-10-97');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('zagashevg@mail.ru','cc46gbsis','Загацкий','Евгений', '32749647364', '+375-(29)-767-77-27');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('ZuttoNaZutto@mail.ru','gco47ncih','Зутто','Анастасия', '3649264923', '+375-(29)-453-78-24');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('ilushenko@mail.ru','4t7cyon74y','Ильющенко','Максим', '0324729685320', '+375-(29)-284-97-27');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('Vodemka@mail.ru','oc3mpuar','Каптюг','Вадим', '36492470496', '+375-(29)-765-39-01');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('Nagushevdimik@mail.ru','c3hg7nhnr','Нагушев','Дмитрий', '3541684632485', '+375-(29)-823-52-01'); 
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('Onilshak@mail.ru','4cgoe8nc','Онил','Ксения', '52727867', '+375-(44)-579-42-07');
insert into CUSTOMERS  (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME,CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS)        values ('KseniyaSinitsa1@mail.ru','hrgrhgni8','Синицына1','Ксения1', '7652786782', '+375-(29)-467-39-27');
------------Создание и заполнение таблицы ADMINS 
create table ADMINS
(  
	ADMINS nvarchar(50) constraint 
	ADMINS_LOGIN primary key,
	ADMINS_PASSWORD nvarchar(20),
	ADMINS_SURNAME  nvarchar(20), 
	ADMINS_NAME  nvarchar(20), 
	ADMINS_CONTACTS nvarchar(100),
	PRODUCTS nvarchar(50) constraint ADMINS_IN_PRODUCTS foreign key
	references PRODUCTS(PRODUCTS),
	SERVICESS nvarchar(50) constraint ADMINS_IN_SERVICESS foreign key
	references SERVICESS(SERVICESS),
) 

  
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_CONTACTS)        values ('AduenkoAl@mail.ru','83mn8uCW','Адуенко','Александа', '+375-(44)-279-45-01');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_CONTACTS)        values ('BelodedEvgen@gmail.ru','n9jdn9','Белодед','Евгений', '+375-(29)-915-26-97');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_CONTACTS)        values ('Varban2000@inbox.ru','u99hewhviy','Варбан','Ульяна', '+375-(44)-615-61-49');
insert into ADMINS  (ADMINS, ADMINS_PASSWORD, ADMINS_SURNAME,ADMINS_NAME, ADMINS_CONTACTS)        values ('OleinicKir@mail.ru','8c2ojob','Олейник','Кирилл', '+375-(29)-315-00-85');

------------Создание и заполнение таблицы ORDERS 
create table ORDERS
(  
	ORDERS int constraint 
	ORDERS_ID primary key,
	SERVICESS nvarchar(50) constraint ORDERS_SERVICESS_TYPE foreign key
	references SERVICESS(SERVICESS),
	PRODUCTS nvarchar(50) constraint ORDERS_PRODUCTS_TYPE foreign key
	references PRODUCTS(PRODUCTS),
	ORDERS_DATE  date, 
	ORDERS_ADRES nvarchar(20), -- нужно брать из работникв специализацию как запрос или через внешний ключ 
    ORDERS_COST float,
	ORDERS_DISCOUNT int, --%
	CUSTOMERS nvarchar(50) constraint ORDERS_OFCUSTOMERS foreign key
	references CUSTOMERS(CUSTOMERS),
	WORKERS nvarchar(20) constraint ORDERS_OFWORKERS foreign key
	references WORKERS(WORKERS), 
	
) 
insert into ORDERS   (ORDERS, SERVICESS, PRODUCTS, ORDERS_DATE, ORDERS_ADRES , ORDERS_COST, ORDERS_DISCOUNT, CUSTOMERS, WORKERS)        values (1,'Безопасность сети','Сетевой адаптер', '2019-05-08','Дзержинакого', 9, 10, 'katerina@gmail.ru', 'Прищеп');
insert into ORDERS   (ORDERS, SERVICESS, PRODUCTS, ORDERS_DATE, ORDERS_ADRES, ORDERS_COST, ORDERS_DISCOUNT, CUSTOMERS, WORKERS)        values (2,'Создание ЛВС','Сетевой адаптер', '2019-05-17','Дзержинакого', 15, 10, 'KseniyaSinitsa@mail.ru', 'Буко');
insert into ORDERS   (ORDERS, SERVICESS, PRODUCTS, ORDERS_DATE, ORDERS_ADRES, ORDERS_COST, ORDERS_DISCOUNT, CUSTOMERS, WORKERS)        values (3,'Поддержка ПО','Сетевой адаптер', '2019-06-25','Дзержинакого', 7, 5, 'ZuttoNaZutto@mail.ru', 'Шрубиков');
insert into ORDERS   (ORDERS, SERVICESS, PRODUCTS, ORDERS_DATE, ORDERS_ADRES, ORDERS_COST, ORDERS_DISCOUNT, CUSTOMERS, WORKERS)        values (4,'IT-аутсорсинг','Сетевой адаптер', '2019-05-30','Дзержинакого', 6, 5, 'AndreykaXXX@inbox.ru', 'Козловский');
