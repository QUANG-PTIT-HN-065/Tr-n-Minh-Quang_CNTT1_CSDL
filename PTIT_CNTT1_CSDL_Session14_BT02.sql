drop database if exists session_14;
create database session_14;
use session_14;

drop table if exists orders;
drop table if exists products;

create table products (
    product_id int auto_increment primary key,
    product_name varchar(50),
    price decimal(10,2),
    stock int
);

create table orders (
    order_id int auto_increment primary key,
    product_id int,
    quantity int,
    total_price decimal(10,2),
    foreign key (product_id) references products(product_id)
);

insert into products (product_name, price, stock)
values ('San pham A', 100.00, 10);

delimiter //

create procedure place_order(
    in p_product_id int,
    in p_quantity int
)
begin
    declare v_stock int;
    declare v_price decimal(10,2);

    start transaction;

    select stock, price
    into v_stock, v_price
    from products
    where product_id = p_product_id
    for update;

    if v_stock is null then
        rollback;
        signal sqlstate '45000'
        set message_text = 'san pham khong ton tai';
    elseif v_stock < p_quantity then
        rollback;
        signal sqlstate '45000'
        set message_text = 'khong du so luong trong kho';
    else
        insert into orders (product_id, quantity, total_price)
        values (p_product_id, p_quantity, v_price * p_quantity);

        update products
        set stock = stock - p_quantity
        where product_id = p_product_id;

        commit;
    end if;
end//

delimiter ;

call place_order(1, 2);

select * from products;
select * from orders;
