drop database hackathon;
create database hackathon;
use hackathon;

-- Bảng người dùng 
create table Users (
	user_id VARCHAR(5) primary key,
    uesr_name VARCHAR(100),
    user_email VARCHAR(100) UNIQUE,
    user_phone VARCHAR(15) UNIQUE
);

-- Bảng sản phẩm 
create table Produtc (
	product_id VARCHAR(5) primary key,
    product_name VARCHAR(150),
    product_price DECIMAL(10,2),
    stock_quantity int
);

-- Bảng đơn hàng
create table Orders (
	order_id int primary key auto_increment,
    user_id VARCHAR(5) references TUser(user_id),
    order_date date,
    total_price DECIMAL(10,2),
    order_status VARCHAR(20)
);

-- Bảng Chi tiết đơn hàng 
create table Order_Detail (
	order_detail_id int auto_increment primary key,
    order_id int references Oder(order_id),
    product_id VARCHAR(5) references Produtc(product_id),
    quantity int,
    unti_price DECIMAL(10,2)
);

-- Thêm Thông Tin Người Dùng 
insert into Users(user_id,uesr_name,user_email,user_phone) value 
('U001', 'Nguyễn Văn An' ,'an.nguyen@gmail.com' ,'0912345678' ),
('U002', 'Trần Thị Bích' ,'bich.tran@gmail.com' ,'0923456789' ),
('U003', 'Lê Hoàng Minh' ,'minh.le@gmail.com' ,'0734567890' ),
('U004', 'Phạm Thu Hà' ,'ha.pham@gmail.com' ,'0845678901' ),
('U005', 'Võ Quốc Huy' ,'huy.vo@gmail.com' ,'0956789012' );


-- Thêm sản phẩm 
insert into Produtc(product_id,
product_name,
product_price,
stock_quantity
) value 
('P001', 'Áo thun nam' ,199000 ,50),
('P002', 'Quần jean nữ' ,399000 ,40 ),
('P003', 'Giày sneaker' ,899000 ,30 ),
('P004', 'Túi xách thời trang' ,599000 ,20),
('P005', 'Đồng hồ đeo tay' ,1299000 ,15);

-- thêm đơn hàng 
insert into Orders(order_id,
user_id,
order_date,
total_price,
order_status
) value 
(1, 'U001','2025-03-01' ,1098000 ,'Completed'),
(2, 'U002','2025-03-02' ,399000 ,'Completed' ),
(3, 'U003','2025-03-03' ,599000 ,'Processing'),
(4, 'U004','2025-03-04' ,599000 ,'Cancelled'),
(5, 'U005','2025-03-05' ,1299000 ,'Pending'),
(6, 'U006','2025-03-03' ,599000 ,'Completed'),
(7, 'U007','2025-03-03' ,599000 ,'Completed');

-- Thêm chi Tiết đơn hàng
insert into Order_Detail(order_detail_id,
order_id,
product_id,
quantity,
unti_price
) value 
(1, 1,'P001' ,2 ,199000),
(2, 2,'P002' ,1,899000 ),
(3, 3,'P003' ,1 ,399000),
(4, 4,'P004' ,1 ,1299000),
(5, 5,'P005' ,1 ,599000);

-- Update users có id U003
update Users
set user_phone = "096532628"
where user_id = "U003";

-- Update đơn hàng có id 3
update Orders
set order_status = "Cancelled"
where Order_id = 3;

delete from orders
where order_status = 'Cancelled' and date(Order_date) < '2025-03-04';
  

select  order_id, order_date, order_status
from Orders
where order_status ="Completed" and date(Order_date) > "2025-03-01";

select uesr_name, user_phone, user_email
from Users
where user_phone LIKE '09%';

select  order_id,user_id, order_date
from Orders
order by order_date desc;

select *
from Orders
where order_status ="Completed"
limit 3;

select user_id,uesr_name
from Users
limit 3 offset 2;

select  order_id,uesr_name, order_date , total_price 
from Users U 
join Orders O on O.order_status = 'Completed';

-- 15 Lấy thông tin các đơn hàng lớn hơn giá trị trung bình của tất cả các đơn  trong bảng Order.
SELECT order_id, order_date, total_price
FROM Orders
WHERE total_price > (SELECT AVG(total_price) FROM Orders);

-- 12 Liệt kê tất cả các sản phẩm trong hệ thống
select  product_id,product_name,order_id
from  Produtc p
left join  Orders o on p.product_id = o.order_id;

select order_status , Total_Order = sum(total_price)
from Orders  
