create database orders;
use orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('pending','completed','cancelled') DEFAULT 'pending'
);

INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
(1, 3200000, '2025-01-10', 'completed'),
(2, 7800000, '2025-01-12', 'pending'),
(3, 1500000, '2025-01-15', 'cancelled'),
(1, 6400000, '2025-01-18', 'completed'),
(4, 9000000, '2025-01-20', 'completed'),
(5, 2200000, '2025-01-21', 'pending'),
(2, 5100000, '2025-01-22', 'completed'),
(3, 12000000, '2025-01-24', 'completed'),
(6, 4500000, '2025-01-25', 'pending'),
(1, 3000000, '2025-01-26', 'completed');

SELECT * FROM orders
WHERE status = 'completed';

SELECT * FROM orders
WHERE total_amount > 5000000;

SELECT * FROM orders
ORDER BY order_date DESC
LIMIT 5;

SELECT * FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;
