CREATE DATABASE ecommerce_products;
USE ecommerce_products;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    status ENUM('active','inactive') NOT NULL
);

INSERT INTO products (product_name, price, stock, status) VALUES
('Phone A1', 1200000, 50, 'active'),
('Phone A2', 1800000, 40, 'active'),
('Phone A3', 2500000, 35, 'active'),
('Phone A4', 2900000, 30, 'active'),
('Phone A5', 3100000, 28, 'active'),
('Tablet B1', 1500000, 25, 'active'),
('Tablet B2', 2200000, 20, 'active'),
('Tablet B3', 2700000, 18, 'active'),
('Tablet B4', 3000000, 15, 'active'),
('Headphone C1', 1100000, 45, 'active'),
('Headphone C2', 1300000, 42, 'active'),
('Headphone C3', 1750000, 37, 'active'),
('Keyboard D1', 1400000, 33, 'active'),
('Keyboard D2', 2100000, 29, 'active'),
('Mouse E1', 1050000, 60, 'active'),
('Mouse E2', 1950000, 55, 'active'),
('Monitor F1', 2800000, 12, 'active'),
('Monitor F2', 2900000, 10, 'active'),
('Speaker G1', 1600000, 22, 'inactive'),
('Speaker G2', 2400000, 18, 'active');

SELECT *
FROM products
WHERE status = 'active'
AND price BETWEEN 1000000 AND 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 0;

SELECT *
FROM products
WHERE status = 'active'
AND price BETWEEN 1000000 AND 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 10;
