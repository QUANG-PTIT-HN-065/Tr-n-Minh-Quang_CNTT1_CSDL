drop database ecommerce_customer_orders;
create database ecommerce_customer_orders;
use ecommerce_customer_orders;

create table customers (
    customer_id int auto_increment primary key,
    full_name varchar(255) not null,
    city varchar(255) not null
);

create table orders (
    order_id int auto_increment primary key,
    customer_id int not null,
    order_date date not null,
    status enum('pending','completed','cancelled') not null,
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);

insert into customers (full_name, city) values
('nguyen van a', 'ha noi'),
('tran thi b', 'ho chi minh'),
('le van c', 'da nang'),
('pham thi d', 'ha noi'),
('hoang van e', 'can tho');

insert into orders (customer_id, order_date, status, total_amount) values
(1, '2025-01-10', 'completed', 3500000),
(1, '2025-01-12', 'completed', 4200000),
(2, '2025-01-11', 'completed', 2800000),
(3, '2025-01-09', 'completed', 5600000),
(4, '2025-01-13', 'completed', 7200000);

select o.order_id, o.order_date, o.status, c.full_name
from orders o
join customers c on o.customer_id = c.customer_id;

select c.customer_id, c.full_name, count(o.order_id) as total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

select c.customer_id, c.full_name, count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 1;

select date(order_date) as order_day,
       sum(total_amount) as total_revenue,
       count(*) as total_orders
from orders
where status = 'completed'
group by date(order_date)
having sum(total_amount) > 10000000
order by order_day;

select c.customer_id, c.full_name, sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

select c.customer_id, c.full_name, max(o.total_amount) as max_order_value
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

select c.customer_id, c.full_name, sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
order by total_spent desc;
