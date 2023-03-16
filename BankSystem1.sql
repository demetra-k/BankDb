create table employees
( emp_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(30) NOT NULL,
  last_name VARCHAR2(30)  NOT NULL,
  addl_name VARCHAR2(30),
  address VARCHAR2(100) NOT NULL,
  phone VARCHAR2(20),
  email VARCHAR2(30),
  job_title VARCHAR2(30) NOT NULL,
  dep_id NUMBER NOT NULL
);

select * from employees;

create table departments
( dep_id NUMBER PRIMARY KEY,
  name VARCHAR2(105)
);

create table customers
( cust_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(30) NOT NULL,
  last_name VARCHAR2(30)  NOT NULL,
  addl_name VARCHAR2(30),
  address VARCHAR2(100) NOT NULL,
  phone VARCHAR2(20),
  email VARCHAR2(30)
);

select * from customers;

ALTER TABLE employees
ADD CONSTRAINT fk_departments
  FOREIGN KEY (dep_id)
  REFERENCES departments(dep_id);
  
  
alter table employees
add salary number;

alter table employees
add date_started DATE DEFAULT sysdate NOT NULL;

insert into departments
values (1,'Операции');
insert into departments
values (2,'Кредитен анализ');
insert into departments
values (3,'Картови разплащания');


insert into employees(emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id, salary)
values (1,'Angel', 'Georgiev', '', 'Bulgaria', '0895465456', 'angelbgpl@gmail.com', 'Operator', 1, '1500');

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id, salary)
values (2,'Vasil', 'Grigorov', '', 'Italy', '0895546456', 'vas@gmail.com', 'Cards', 3, '2500');

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id, salary)
values (3,'Petar', 'Angelov', '', 'Bulgaria', '0895454556', 'Pet@gmail.com', 'Credit operator', 2, '4500');

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id, salary)
values (4,'Emiliq', 'Angelova', '', 'Bulgaria', '0795455576', 'emi@gmail.com', 'Credit operator', 2, '8500');

insert into employees(emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id, salary)
values (5,'Asen', 'Georgiev', '', 'Bulgaria', '0895465456', 'angelbgpl@gmail.com', 'Operator', 1, '1600');


insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (1,'Ivan', 'Ivanov', '', 'France', '0892165', 'iv@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (2,'Georgi', 'Petrov', '', 'Bulgaria', '089216655', 'gi@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (3,'Silvia', 'Ivanova', '', 'Germany', '089215465', 'siv@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (4,'Petq', 'Petrova', '', 'Rome', '089215465', 'pet@gmail.com');


create table bank_account
(
account_number number(16) PRIMARY KEY,
amount decimal(20,2) not null,
currency varchar(3) default 'BGN'
);

select * from bank_account;


/*Бизнес заявки част 1*/

/*1. Да се създаде листинг на имената на всички отдели в банката*/

select name from departments;


/*2. Да се създаде листинга на месечните възнаграждения на всички
служители, в листинга е необходимо да присъстват двете имена
на служителя и неговата заплата*/

select first_name, last_name, salary from employees;


/*3. Да се създаде листинг на всички служители в банката в листинга
трябва да присъстват двете имена на служителите и новогенерирани
имейли, които да се състоят от конкатенирани първото и второ име
на служителя разделени с точка. Имената на служителите трябва да
бъдат с малки букви в имейла. Домейна на компанията е
bankoftomarow.bg*/

select lower(first_name||'.'||last_name||'@bankoftomarow.bg') as email, first_name, last_name, salary
from employees;

/*4. Намерете всички служители които банката дефинира като старши
служители. Старши служители са всички които работят в компанията
от 5 години.*/

update employees
set date_started = '2012-12-12'
where emp_id = 1;

update employees
set date_started = '2017-1-12'
where emp_id = 2;

update employees
set date_started = '1998-12-7'
where emp_id = 3;

update employees
set date_started = '2022-12-12'
where emp_id = 4;


select *
from employees
where date_started < add_months(sysdate, -60);

select * from employees;

/*5. Намерете всички служители, чиито имена (първо / второ или
допълнително съдържат буквата l)*/
update employees
set addl_name = 'Anko'
where emp_id = 1;

update employees
set addl_name = 'Vasi'
where emp_id = 2;

update employees
set addl_name = 'PetAngel'
where emp_id = 3;

select * from employees
where upper(first_name) like '%I%' or upper(addl_name)like '%I%' or upper(last_name) like '%I%';

select * from employees;


/*Бизнес заявки част 2*/
/*1. Да се реализират примерни inserta в тази таблица*/

CREATE TABLE employees_history
(
change_id number GENERATED as IDENTITY PRIMARY KEY,
emp_id number,
column_name varchar2(105),
new_value varchar2(105),
old_value varchar2(105),
changed_by varchar2(105),
changed_date date default sysdate
);


alter table employees 
add department varchar(50);

update employees
set department = 1
where emp_id = 1;

update employees
set department = 2
where emp_id = 2;

update employees
set department = 3
where emp_id = 3;

select emp_id, count(emp_id) as "Number of changes"
from employees_history
where changed_date > add_months(sysdate, -2)
group by emp_id
having count(emp_id)>1;

update employees_history
set changed_date = '12-FEB-22'
where change_id = 3;


select *
from employees
left join employees_history
on employees.emp_id=employees_history.emp_id
where employees_history.emp_id is null;


/*Бизнес заявки част 3*/
/*1. Да се реализира листинг показващ всички служители които са били
уволнени от компанията*/

alter table  employees
add employablee varchar(150);

update employees
set employablee = 'Fired'
where emp_id = 1;

update employees
set employablee = 'Fired'
where emp_id = 3;

select * from employees
where employablee = 'Fired';

/*2. Да се реализира листинг на всички служители които са в майчинство
в момента.*/
update employees
set employablee = 'In Maternity'
where emp_id = 4;

select * from employees
where employablee = 'In Maternity';

/*3. Да се реализира листинг на всички служители които са в отпуска
/ болничен в момента*/
update employees
set employablee = 'Hospital'
where emp_id = 2;

select * from employees
where employablee = 'Hospital';

select * from employees;

/*4. Намерете всички служители които нямат ръководител*/

alter table  employees
add manager_name varchar(150);

update employees
set manager_name = 'Silviq Petrova'
where emp_id = 3;

update employees
set manager_name = 'Ivan Ivanov'
where emp_id = 1;

update employees
set manager_name = 'Stoqn Stoqnov'
where emp_id = 2;

select * from employees
where manager_name is null;

/*5. Намерете всички старши служители които получават заплата по висока
от 5000 лв. Подредете ги в обратен азбучен ред, като се има предвид
тяхното първо име.*/

update employees
set salary = '9500'
where emp_id = 2;

update employees
set salary = '5500'
where emp_id = 3;

select *
from employees
where date_started < add_months(sysdate, -60) and salary > 5000
order by first_name desc;

/*6. Намерете петимата най-високоплатени служители във всеки отдел.
Групирайте ги по отдели.*/

select name,first_name,salary
from employees
inner join departments
on employees.dep_id=departments.dep_id 
where rownum <= 5
group by name,first_name,salary
order by salary desc;

select * from employees;


/*7. Намерете отдела или отделите, в които / които служителите
сумарно получават най-ниска заплата.*/


SELECT Sum(salary) as "Lowest Salary"
FROM employees
INNER JOIN departments
ON employees.dep_id=departments.dep_id 
WHERE rownum <= 1
ORDER BY salary ASC;


select * from departments;
select * from employees;

/*8.Намерете средната заплата във всеки отдел, групирайте по средна
заплата и отдел*/
SELECT dep_id, AVG(salary) AS "AVG Salary"
FROM employees
GROUP BY dep_id ;

/*Бизнес заявки част 4*/
/*1. Да се изведат всички клиенти които имат сметки във валута. ( различна
от BGN )*/
select * from customers;

insert into bank_account
(account_number,amount,currency)
values (1,3552.556,'EUR');

insert into bank_account
(account_number,amount)
values (2,5222.766);

insert into bank_account
(account_number,amount,currency)
values (3,250322.966,'BTC');


update bank_account
set amount = 0
where account_number = 4;

insert into bank_account
(account_number,amount)
values (4);

select * from bank_account;


select * from 
customers
join bank_account
on customers.cust_id=bank_account.account_number
where bank_account.currency <> 'BGN';


/*2. Да се изведат всички клиенти които имат сметки с нулево парично салдо. Напълно
празни.*/
select * from customers
join bank_account
on customers.cust_id=bank_account.account_number
where bank_account.amount = 0;


/*3. Да се добави название на сметката на всеки клиент. Названието на сметката му, е
името на клиента последвано от думата сметка и валутата на сметката.
Актуализирайте всички клиенти*/

alter table bank_account
add account_name varchar(105);

select * from bank_account;


merge into bank_account
using customers
on (bank_account.account_number = customers.cust_id)
when matched then
update set account_name = customers.first_name || 'BankAccount' || bank_account.currency;

select * from bank_account;


/*1. Разработка на модул за добавяне, премахване, променяне и
извеждане (CRUD) на потребители (клиенти).*/
CREATE OR REPLACE PROCEDURE createCustomer 
(
account_number IN customers.cust_id%TYPE,
first_name IN customers.first_name%TYPE,
last_name IN customers.last_name%TYPE,
addl_name IN customers.addl_name%TYPE,
address IN customers.address%TYPE,
phone IN customers.phone%TYPE,
email IN customers.email%TYPE
)
IS
BEGIN 
  INSERT INTO customers(cust_id,first_name,last_name,addl_name,address,phone,email)
  VALUES(account_number,first_name,last_name,addl_name,address,phone,email);
  dbms_output.put_line('Customer Added!');
END createCustomer;

execute createCustomer();


PROCEDURE deleteCustomer 
(cust_id IN customers.cust_id%TYPE)
IS
BEGIN 
  DELETE FROM customers
  WHERE cust_id = cust_id;
    dbms_output.put_line('Customer Deleted!');
END deleteCustomer;

END;



/*2. Паролата на клиента да бъде хеширана.*/
SELECT
    lower(password) AS password,
    dbms_crypto.hash(typ => 2, src => utl_raw.cast_to_raw(password)) hashing
FROM
    customers;
