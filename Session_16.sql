
-- CÂU 2: TẠO CƠ SỞ DỮ LIỆU VÀ BẢNG

drop database if exists quanlybanhang;
create database quanlybanhang;
use quanlybanhang;

create table customers (
    customer_id int auto_increment primary key,
    customer_name varchar(100) not null,
    phone varchar(20) not null unique,
    address varchar(255)
);

create table products (
    product_id int auto_increment primary key,
    product_name varchar(100) not null unique,
    price decimal(10,2) not null,
    quantity int not null check (quantity >= 0),
    category varchar(50) not null
);

create table employees (
    employee_id int auto_increment primary key,
    employee_name varchar(100) not null,
    birthday date,
    position varchar(50) not null,
    salary decimal(10,2) not null,
    revenue decimal(10,2) default 0
);

create table orders (
    order_id int auto_increment primary key,
    customer_id int,
    employee_id int,
    order_date datetime default current_timestamp,
    total_amount decimal(10,2) default 0,
    foreign key (customer_id) references customers(customer_id),
    foreign key (employee_id) references employees(employee_id)
);

create table orderdetails (
    order_detail_id int auto_increment primary key,
    order_id int,
    product_id int,
    quantity int not null check (quantity > 0),
    unit_price decimal(10,2) not null,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

-- CÂU 3: CHỈNH SỬA CẤU TRÚC BẢNG

alter table customers
add column email varchar(100) not null unique;

alter table employees
drop column birthday;

-- PHẦN II: TRUY VẤN DỮ LIỆU
-- CÂU 4: CHÈN DỮ LIỆU

insert into customers(customer_name, phone, address, email) values
('Nguyen Van A','0901','HN','a@gmail.com'),
('Tran Van B','0902','HCM','b@gmail.com'),
('Le Van C','0903','DN','c@gmail.com'),
('Pham Van D','0904','HP','d@gmail.com'),
('Hoang Van E','0905','CT','e@gmail.com');

insert into products(product_name, price, quantity, category) values
('Laptop',1000,50,'IT'),
('Phone',500,100,'IT'),
('Tablet',300,80,'IT'),
('Mouse',20,200,'Accessory'),
('Keyboard',30,150,'Accessory');

insert into employees(employee_name, position, salary) values
('Emp A','Sales',1000),
('Emp B','Sales',1200),
('Emp C','Manager',2000),
('Emp D','Sales',1100),
('Emp E','Sales',1150);

insert into orders(customer_id, employee_id) values
(1,1),(2,2),(3,3),(4,4),(5,5);

insert into orderdetails(order_id, product_id, quantity, unit_price) values
(1,1,2,1000),
(1,2,1,500),
(2,3,3,300),
(3,4,5,20),
(4,5,2,30);

-- CÂU 5: TRUY VẤN CƠ BẢN

select customer_id, customer_name, email, phone, address
from customers;

update products
set product_name = 'Laptop Dell XPS', price = 99.99
where product_id = 1;

select o.order_id, c.customer_name, e.employee_name, o.total_amount, o.order_date
from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id;

-- CÂU 6: TRUY VẤN ĐẦY ĐỦ

select c.customer_id, c.customer_name, count(o.order_id) total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id;

select e.employee_id, e.employee_name, sum(o.total_amount) revenue
from employees e
join orders o on e.employee_id = o.employee_id
where year(o.order_date) = year(curdate())
group by e.employee_id;

select p.product_id, p.product_name, sum(od.quantity) total_quantity
from orderdetails od
join products p on od.product_id = p.product_id
where month(curdate()) = month(curdate())
group by p.product_id
having total_quantity > 100
order by total_quantity desc;

-- CÂU 7: TRUY VẤN NÂNG CAO


select c.customer_id, c.customer_name
from customers c
left join orders o on c.customer_id = o.customer_id
where o.order_id is null;

select *
from products
where price > (select avg(price) from products);

select c.customer_id, c.customer_name, sum(o.total_amount) total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id
having total_spent = (
    select max(total)
    from (
        select sum(total_amount) total
        from orders
        group by customer_id
    ) t
);


-- CÂU 8: TẠO VIEW

create view view_order_list as
select o.order_id, c.customer_name, e.employee_name, o.total_amount, o.order_date
from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id
order by o.order_date desc;

create view view_order_detail_product as
select od.order_detail_id, p.product_name, od.quantity, od.unit_price
from orderdetails od
join products p on od.product_id = p.product_id
order by od.quantity desc;

-- CÂU 9: STORED PROCEDURE

delimiter //

create procedure proc_insert_employee(
    in p_name varchar(100),
    in p_position varchar(50),
    in p_salary decimal(10,2),
    out new_id int
)
begin
    insert into employees(employee_name, position, salary)
    values (p_name, p_position, p_salary);
    set new_id = last_insert_id();
end//

create procedure proc_get_orderdetails(in p_order_id int)
begin
    select * from orderdetails where order_id = p_order_id;
end//

create procedure proc_cal_total_amount_by_order(in p_order_id int)
begin
    select count(distinct product_id) as total_products
    from orderdetails
    where order_id = p_order_id;
end//

delimiter ;

-- CÂU 10: TRIGGER

delimiter //

create trigger trigger_after_insert_order_details
before insert on orderdetails
for each row
begin
    declare v_qty int;

    select quantity into v_qty
    from products
    where product_id = new.product_id;

    if v_qty < new.quantity then
        signal sqlstate '45000'
        set message_text = 'So luong san pham trong kho khong du';
    else
        update products
        set quantity = quantity - new.quantity
        where product_id = new.product_id;
    end if;
end//

delimiter ;

-- CÂU 11: TRANSACTION

delimiter //

create procedure proc_insert_order_details(
    in p_order_id int,
    in p_product_id int,
    in p_quantity int,
    in p_price decimal(10,2)
)
begin
    start transaction;

    if not exists (select 1 from orders where order_id = p_order_id) then
        rollback;
        signal sqlstate '45000'
        set message_text = 'khong ton tai ma hoa don';
    else
        insert into orderdetails(order_id, product_id, quantity, unit_price)
        values (p_order_id, p_product_id, p_quantity, p_price);

        update orders
        set total_amount = total_amount + (p_quantity * p_price)
        where order_id = p_order_id;

        commit;
    end if;
end//

delimiter ;
