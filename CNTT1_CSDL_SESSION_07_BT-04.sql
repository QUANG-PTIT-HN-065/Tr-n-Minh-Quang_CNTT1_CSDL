drop database if exists shop_products;
create database shop_products;
use shop_products;

create table products (
    id int primary key auto_increment,
    name varchar(255),
    price decimal(10,2)
);

create table customers (
    id int primary key auto_increment,
    name varchar(250),
    email varchar(250)
);

create table orders (
    id int primary key auto_increment,
    customer_id int,
    order_date date,
    total_amount decimal(10,2)
);

insert into products(name,price) values
('banh mi',20000),
('tra sua',45000),
('ca phe den',30000),
('nuoc ep cam',50000),
('banh quy',25000),
('soda chanh',38000),
('tra dao',42000);

insert into customers(name,email) values
('nguyen van a','a@email.com'),
('tran thi b','b@email.com'),
('le van c','c@email.com'),
('pham thi d','d@email.com'),
('hoang van e','e@email.com');


insert into orders(customer_id,order_date,total_amount) values
(1,'2025-01-10',3000000),
(1,'2025-01-12',4200000),
(2,'2025-01-11',2800000),
(3,'2025-01-09',5600000),
(3,'2025-01-20',3100000),
(4,'2025-01-15',2700000);

select c.name,
       (select count(*) from orders o where o.customer_id=c.id) as total_orders
from customers c;

