drop database shop_products;
create database shop_products;
use shop_products;

create table products (
    id int primary key auto_increment,
    name varchar(255),
    price decimal(10,2)
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

insert into orders(customer_id, order_date, total_amount) values
(1,'2025-01-10',3000000),
(2,'2025-01-11',4500000),
(3,'2025-01-12',5200000),
(4,'2025-01-13',2500000),
(5,'2025-01-14',7000000),
(6,'2025-01-15',6100000);

select id, customer_id, order_date, total_amount
from orders
where total_amount > (
    select avg(total_amount)
    from orders
);