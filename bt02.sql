create database customers;
use customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    city VARCHAR(255),
    status ENUM('active', 'inactive') DEFAULT 'active'
);

INSERT INTO customers (full_name, email, city, status) 
VALUES
('Nguyễn Văn A', 'vana@gmail.com', 'TP.HCM', 'active'),
('Trần Thị B', 'thib@gmail.com', 'Hà Nội', 'active'),
('Lê Minh C', 'minhc@gmail.com', 'Đà Nẵng', 'inactive'),
('Phạm Thu D', 'thud@gmail.com', 'TP.HCM', 'active'),
('Hoàng Nam E', 'name@gmail.com', 'Hà Nội', 'inactive'),
('Bùi Quang F', 'quangf@gmail.com', 'Cần Thơ', 'active'),
('Đỗ Hải G', 'haig@gmail.com', 'Hà Nội', 'active'),
('Võ Ngọc H', 'ngoch@gmail.com', 'TP.HCM', 'inactive'),
('Trịnh Tuấn I', 'tuani@gmail.com', 'Huế', 'active'),
('Mai Hồng K', 'hongk@gmail.com', 'Hà Nội', 'active');

SELECT * 
FROM customers;

SELECT * 
FROM customers
WHERE city = 'TP.HCM';

SELECT * 
FROM customers
WHERE status = 'active'
  AND city = 'Hà Nội';

SELECT * 
FROM customers
ORDER BY full_name ASC;

