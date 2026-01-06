drop database if exists shop_products;
create database shop_products;
use shop_products;

create table products (
    id int primary key auto_increment,
    name varchar(255),
    price decimal(10,2)
);


create table order_items (
    order_id int,
    product_id int,
    quantity int
);

insert into products(name,price) values
('banh mi',20000),
('tra sua',45000),
('ca phe den',30000),
('nuoc ep cam',50000),
('banh quy',25000),
('soda chanh',38000),
('tra dao',42000);

insert into order_items values
(1,1,5),
(2,2,3),
(3,3,4),
(4,5,6),
(5,2,2),
(6,1,3),
(7,4,1);

select id, name, price
from products
where id in (
    select product_id
    from order_items
);
