drop database if exists ecommerce_db;
create database ecommerce_db;
use ecommerce_db;

create table customers (
    id int primary key auto_increment,
    name varchar(255),
    email varchar(255)
);

create table orders (
    id int primary key auto_increment,
    customer_id int,
    order_date date,
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(id)
);

insert into customers(name,email) values
('nguyen van a','a@email.com'),
('tran thi b','b@email.com'),
('le van c','c@email.com'),
('pham thi d','d@email.com'),
('hoang van e','e@email.com'),
('do thi f','f@email.com'),
('ngo van g','g@email.com');

insert into orders(customer_id,order_date,total_amount) values
(1,'2025-01-10',3200000),
(2,'2025-01-08',2800000),
(3,'2025-01-12',4500000),
(4,'2025-01-15',2300000),
(5,'2025-01-20',5100000),
(6,'2025-01-22',1900000);

select id,name,email
from customers
where id in (select customer_id from orders);
