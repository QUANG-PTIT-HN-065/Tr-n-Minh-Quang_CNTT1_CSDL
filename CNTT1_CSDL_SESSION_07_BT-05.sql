drop database shop_products_maxbuyer;-- 
create database shop_products_maxbuyer;
use shop_products_maxbuyer;

create table customers (
    id int primary key auto_increment,
    name varchar(255),
    email varchar(255)
);

create table orders (
    id int primary key auto_increment,
    customer_id int,
    order_date date,
    total_amount decimal(10,2)
);

insert into customers(name,email) values
('nguyen van a','a@email.com'),
('tran thi b','b@email.com'),
('le van c','c@email.com'),
('pham thi d','d@email.com'),
('hoang van e','e@email.com');

insert into orders(customer_id,order_date,total_amount) values
(1,'2025-01-12',2200000),
(2,'2025-01-11',2800000),
(3,'2025-01-09',5600000),
(4,'2025-01-15',7700000),
(5,'2025-01-20',4100000);

select name, email
from customers
where id in (
    select customer_id
    from orders
    group by customer_id
    having sum(total_amount) = (
        select max(total_spent)
        from (
            select customer_id, sum(total_amount) as total_spent
            from orders
            group by customer_id
        ) t
    )
);

