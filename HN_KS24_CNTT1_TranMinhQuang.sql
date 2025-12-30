create database library;
use library;

create table Reader (
	reader_id int auto_increment PRIMARY KEY,
    reader_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    register_date DATE DEFAULT (CURRENT_DATE)
);

create table Book (
	book_id int auto_increment PRIMARY KEY,
    book_title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    publish_year int check(publish_year >= 1900)
);

create table Borrow (
	reader_id int,
    book_id int,
    borrow_date DATE DEFAULT (CURRENT_DATE) ,
    return_date date
);

alter table Reader add email VARCHAR(100) UNIQUE;
alter table Book modify author VARCHAR(150);
alter table Borrow add constraint return_date check(return_date > borrow_date);

INSERT INTO Reader (reader_id, reader_name, phone,register_date, email)
VALUES 
(1, 'Nguyễn Văn An', '0901234567','2024-09-01', 'a.nguyen@example.com'),
(2, 'Trần Thị Bình',   '0901234567','2024-09-01', 'b.tran@example.com'),
(3, 'Lê Minh Châu',    '0901234567','2024-09-01', 'c.le@example.com');

INSERT INTO Book (book_id,book_title,author, publish_year)
VALUES 
(1, 'Lập trình C căn bản', 'Nguyễn Văn A',2018),
(2, 'Lập trình C căn bản', 'Nguyễn Văn A',2018),
(3, 'Lập trình C căn bản', 'Nguyễn Văn A',2018);

INSERT INTO Borrow  (reader_id,book_id,borrow_date, return_date)
VALUES 
(1, 101, '2024-09-15',NULL),
(2, 101, '2024-09-15',NULL),
(3, 101, '2024-09-15',NULL);

