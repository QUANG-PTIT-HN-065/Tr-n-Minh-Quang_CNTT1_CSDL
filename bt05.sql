CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('pending','completed','cancelled') NOT NULL
);

INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
(1, 2500000, '2025-01-02', 'completed'),
(2, 5200000, '2025-01-03', 'pending'),
(3, 3100000, '2025-01-04', 'completed'),
(1, 7200000, '2025-01-05', 'completed'),
(4, 1450000, '2025-01-06', 'pending'),
(2, 8600000, '2025-01-07', 'completed'),
(5, 1950000, '2025-01-08', 'completed'),
(3, 980000, '2025-01-09', 'pending'),
(6, 4500000, '2025-01-10', 'completed'),
(4, 6100000, '2025-01-11', 'completed'),
(7, 3300000, '2025-01-12', 'pending'),
(5, 2800000, '2025-01-13', 'completed'),
(8, 1200000, '2025-01-14', 'cancelled'),
(6, 7500000, '2025-01-15', 'completed'),
(3, 2650000, '2025-01-16', 'completed');

SELECT *
FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC, order_id DESC
LIMIT 5;

SELECT *
FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 5;

SELECT *
FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 10;
