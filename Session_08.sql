drop database if exists shop_online;
create database shop_online;
use shop_online;

create table customers (
    customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(10) not null unique
);

create table categories (
    category_id int primary key auto_increment,
    category_name varchar(255) not null unique
);

create table products (
    product_id int primary key auto_increment,
    product_name varchar(255) not null unique,
    price decimal(10,2) not null check (price > 0),
    category_id int not null,
    foreign key (category_id) references categories(category_id)
);

create table orders (
    order_id int primary key auto_increment,
    customer_id int not null,
    order_date datetime default current_timestamp,
    status enum('pending','completed','cancel') default 'pending',
    foreign key (customer_id) references customers(customer_id)
);

create table order_items (
    order_item_id int primary key auto_increment,
    order_id int,
    product_id int,
    quantity int not null check (quantity > 0),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into customers(customer_name,email,phone) values
('nguyen van a','a@email.com','0911111111'),
('tran thi b','b@email.com','0922222222'),
('le van c','c@email.com','0933333333'),
('pham thi d','d@email.com','0944444444'),
('hoang van e','e@email.com','0955555555');

insert into categories(category_name) values
('do uong'),
('banh keo'),
('thoi trang'),
('dien tu'),
('sach vo');

insert into products(product_name,price,category_id) values
('tra sua',45000,1),
('ca phe den',30000,1),
('banh quy bo',52000,2),
('ao thun cotton',150000,3),
('tai nghe bluetooth',350000,4),
('nuoc ep tao',42000,1),
('sach lap trinh sql',120000,5);

insert into orders(customer_id,status) values
(1,'completed'),
(1,'pending'),
(2,'completed'),
(3,'completed'),
(4,'cancel'),
(5,'completed');

insert into order_items(order_id,product_id,quantity) values
(1,1,2),
(1,3,1),
(2,2,1),
(3,4,2),
(3,1,1),
(4,5,1),
(5,6,3),
(6,7,1);

-- PHAN A
select * from categories;
select * from orders where status = 'completed';
select * from products order by price desc;
select * from products order by price desc limit 2,5;

-- PHAN B
select p.product_id,p.product_name,c.category_name
from products p
join categories c on p.category_id=c.category_id;

select o.order_id,o.order_date,c.customer_name,o.status
from orders o
join customers c on o.customer_id=c.customer_id;

select o.order_id,sum(oi.quantity) as total_quantity
from orders o
join order_items oi on o.order_id=oi.order_id
group by o.order_id;

select customer_id,count(*) as total_orders
from orders
group by customer_id;

select customer_id,count(*) as total_orders
from orders
group by customer_id
having count(*)>=2;

select c.category_name,
       avg(p.price) as avg_price,
       min(p.price) as min_price,
       max(p.price) as max_price
from products p
join categories c on p.category_id=c.category_id
group by c.category_id,c.category_name;

-- PHAN C
select *
from products
where price > (select avg(price) from products);

select *
from customers
where customer_id in (select distinct customer_id from orders);

select order_id
from order_items
group by order_id
order by sum(quantity) desc
limit 1;

select customer_name
from customers
where customer_id in (
    select o.customer_id
    from orders o
    where o.order_id in (
        select oi.order_id
        from order_items oi
        where oi.product_id in (
            select p.product_id
            from products p
            where p.category_id = (
                select category_id
                from products
                group by category_id
                order by avg(price) desc
                limit 1
            )
        )
    )
);

select customer_id,sum(total_qty) as total_quantity
from (
    select o.customer_id,sum(oi.quantity) as total_qty
    from orders o
    join order_items oi on o.order_id=oi.order_id
    group by o.customer_id
) t
group by customer_id;

select *
from products
where price = (
    select max(price)
    from products
);
