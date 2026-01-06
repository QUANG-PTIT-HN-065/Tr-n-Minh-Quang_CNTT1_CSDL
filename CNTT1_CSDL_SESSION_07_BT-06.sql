drop database shop_products_maxbuyer;-- 
create database shop_products_maxbuyer;
use shop_products_maxbuyer;

create table customers (
    id int primary key auto_increment,
    name varchar(255),
    email varchar(255)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(12,2)
);


insert into customers(name,email) values
('nguyen van a','a@email.com'),
('tran thi b','b@email.com'),
('le van c','c@email.com'),
('pham thi d','d@email.com'),
('hoang van e','e@email.com');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(1, 1, '2025-01-01', 120.00),
(2, 2, '2025-01-02', 30.00),
(3, 1, '2025-01-05', 180.00),
(4, 3, '2025-01-06', 90.00),
(5, 2, '2025-01-10', 250.00);

SELECT 
    customer_id, 
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) >
(
    SELECT AVG(total_per_customer)
    FROM (
        SELECT customer_id, SUM(total_amount) AS total_per_customer
        FROM orders
        GROUP BY customer_id
    ) AS t
);


