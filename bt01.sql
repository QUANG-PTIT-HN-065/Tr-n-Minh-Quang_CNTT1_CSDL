create database products;
use products;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    status ENUM('active', 'inactive') NOT NULL
);

INSERT INTO products (product_id, product_name, price, stock, status)
VALUES
(1, 'Chuột không dây Logitech M185', 299000, 120, 'active'),
(2, 'Bàn phím cơ Keychron K2', 1890000, 45, 'active'),
(3, 'Tai nghe Bluetooth Sony WH-CH510', 1290000, 32, 'active'),
(4, 'Ổ cứng SSD Samsung 1TB', 2090000, 20, 'inactive'),
(5, 'Màn hình Dell UltraSharp 24"', 4590000, 15, 'active'),
(6, 'Laptop Acer Aspire 7', 16990000, 10, 'active'),
(7, 'Cáp sạc Type-C Anker', 159000, 200, 'active'),
(8, 'Loa Bluetooth JBL Go 3', 890000, 50, 'inactive'),
(9, 'USB 32GB Kingston', 119000, 300, 'active'),
(10, 'Webcam Logitech C920', 1590000, 25, 'active');

SELECT *
FROM products;

SELECT *
FROM products
WHERE status = 'active';

SELECT *
FROM products
WHERE price > 1000000;

SELECT *
FROM products
WHERE status = 'active'
ORDER BY price ASC;



