create database products;
use products;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    sold_quantity INT NOT NULL,
    status ENUM('active','inactive') NOT NULL
);

INSERT INTO products (product_name, price, stock, sold_quantity, status) VALUES
('Laptop A', 18500000, 20, 320, 'active'),
('Laptop B', 14500000, 15, 280, 'active'),
('Phone X', 9500000, 30, 500, 'active'),
('Phone Y', 7200000, 25, 410, 'active'),
('Tablet M', 6200000, 18, 220, 'active'),
('Tablet N', 5400000, 22, 190, 'inactive'),
('Headphone Z', 1500000, 40, 650, 'active'),
('Headphone S', 1200000, 35, 420, 'active'),
('Keyboard K1', 850000, 50, 300, 'active'),
('Keyboard K2', 780000, 48, 260, 'active'),
('Mouse M1', 450000, 60, 480, 'active'),
('Mouse M2', 390000, 55, 350, 'inactive'),
('Monitor A', 3200000, 12, 140, 'active'),
('Monitor B', 2800000, 10, 110, 'active'),
('Speaker P', 2100000, 18, 170, 'active');

SELECT * FROM products
ORDER BY sold_quantity DESC
LIMIT 10;

SELECT * FROM products
ORDER BY sold_quantity DESC
LIMIT 5 OFFSET 10;

SELECT * FROM products
WHERE price < 2000000
ORDER BY sold_quantity DESC;
