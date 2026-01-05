drop database shopdb_full;
create database shopdb_full;
use shopdb_full;

create table customers (
    customer_id int primary key auto_increment,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
    order_id int primary key auto_increment,
    customer_id int,
    order_date date,
    status enum('pending','completed','cancelled'),
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);

create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into customers(full_name,city) values
('nguyen van a','ha noi'),
('tran thi b','ho chi minh'),
('le van c','da nang'),
('pham thi d','ha noi'),
('hoang van e','can tho');

insert into orders(customer_id,order_date,status,total_amount) values
(1,'2025-01-10','completed',3500000),
(1,'2025-01-12','completed',4200000),
(2,'2025-01-11','completed',2800000),
(2,'2025-01-15','pending',1500000),
(3,'2025-01-09','completed',5200000),
(3,'2025-01-20','completed',4800000),
(3,'2025-01-25','completed',3200000),
(4,'2025-01-18','cancelled',2100000),
(5,'2025-01-22','completed',2700000);

insert into products values
(1,'banh mi',20000.00),
(2,'tra sua',45000.00),
(3,'ca phe den',30000.00),
(4,'nuoc ep cam',50000.00),
(5,'banh quy',25000.00);

insert into order_items values
(1,1,10),
(1,2,5),
(2,3,8),
(3,4,12),
(4,5,6),
(5,2,15),
(6,3,10),
(7,1,9),
(8,4,7),
(9,5,11);

select p.product_id,p.product_name,sum(order_items.quantity) as total_sold
from products p
join order_items on order_items.product_id=p.product_id
group by p.product_id,p.product_name;

select p.product_id,p.product_name,sum(order_items.quantity*p.price) as total_revenue
from products p
join order_items on order_items.product_id=p.product_id
group by p.product_id,p.product_name
having sum(order_items.quantity*p.price) > 5000000;

select customers.customer_id,customers.full_name,count(orders.order_id) as total_orders,sum(orders.total_amount) as total_spent,avg(orders.total_amount) as avg_order_value
from customers
join orders on orders.customer_id=customers.customer_id
group by customers.customer_id,customers.full_name
having count(orders.order_id) >= 3 and sum(orders.total_amount) > 10000000
order by total_spent desc;

select products.product_name,sum(order_items.quantity) as total_quantity,sum(order_items.quantity*products.price) as total_revenue,avg(products.price) as avg_price
from products
join order_items on order_items.product_id=products.product_id
group by products.product_name
having sum(order_items.quantity) >= 10
order by total_revenue desc
limit 5;
