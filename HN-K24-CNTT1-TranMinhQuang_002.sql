drop database Projetc;
create database Projetc;
use Projetc;

create table Customers (
	Customer_ID varchar(50) primary key,
    Full_Name varchar(100),
    Phone_Number varchar(50)unique,
    Email varchar(100) unique,
    Join_Date date
);

create table Insurance_Packages (
	Package_ID varchar(50) primary key,
    Package_Name  varchar(100),
    Max_Limit decimal,
    Base_Premium decimal

);

create table Policies (
    Policy_ID varchar(50) primary key,
    Customer_ID varchar(50),
    Package_ID varchar(50),
    Start_Date date,
    End_Date date,
	Status varchar(50),
    foreign key (Customer_ID) references Customers(Customer_ID),
    foreign key (Package_ID) references Insurance_Packages(Package_ID)
);

create table Claims(
	Claim_ID varchar(50) primary key,
    Policy_ID varchar(50),
    Claim_Date date,
    Claim_Amount decimal,
    Status varchar(50),
    foreign key (Policy_ID) references Policies(Policy_ID)
);

create table Claim_Processing_Log (
	Log_ID varchar(50) primary key,
    Claims_ID1 varchar(50),
    Action_Detail varchar(200),
    Recorded_At datetime,
    Processor varchar(100),
    foreign key (Claims_ID1) references Claims(Claim_ID)
);

insert into Customers value
("C001","Nguyen Hoang Long","0901112223","Hoang.nh@gmail.com","2024-01-15"),
("C002","Tran Thi Kim Anh","0988877766","anh.tk@yahoo.com","2024-03-10"),
("C003","Le Hoang Nam","0903334445","nam.lh@outlook.com","2025-05-20"),
("C004","Pham Minh Duc","0355556667","duc.pm@gmail.com","2025-08-12"),
("C005","Hoang Thu Thao","0779998881","thao.ht@gmail.com","2026-01-01");

insert into Insurance_Packages value 
("PKG01","Bảo hiểm Sức khỏe Gold",500000000,5000000),
("PKG02","Bảo hiểm Ô tô Liberty",1000000000,15000000),
("PKG03","Bảo hiểm Nhân thọ An Bình",2000000000,25000000),
("PKG04","Bảo hiểm Du lịch Quốc tế",100000000,1000000),
("PKG05","Bảo hiểm Tai nạn 24/7",200000000,2500000);

insert into Policies value
("POL101","C001","PKG01","2024-12-15","2025-01-15","Expired"),
("POL102","C002","PKG02","2024-03-10","2026-03-10","Active"),
("POL103","C003","PKG03","2025-05-20","2035-05-20","Active"),
("POL104","C004","PKG04","2025-08-12","2025-09-12","Expired"),
("POL105","C005","PKG01","2026-01-01","2027-01-01","Active");

insert into Claims value
("CLM901","POL102","2024-01-15",12000000,"Expired"),
("CLM902","POL103","2024-03-10",50000000,"Active"),
("CLM903","POL101","2025-05-20",5500000,"Active"),
("CLM904","POL105","2025-08-12",2000000,"Expired"),
("CLM905","POL105","2026-01-01",190000000,"Active");

insert into Claim_Processing_Log value
("L001","CLM901","Đã nhận hồ sơ hiện trường","2024-06-15 09:00","Admin_01"),
("L002","CLM901","Chấp nhận bồi thường xe tai nạn","2024-06-20 14:30","Admin_01"),
("L003","CLM902","Đang thẩm định hồ sơ bệnh án","2025-10-21 10:00","Admin_02"),
("L004","CLM904","Từ chối do lỗi cố ý của khách hàng","2026-01-16 16:00","Admin_03"),
("L005","CLM905","Đã thanh toán qua chuyển khoản","2025-02-15 08:30","Accountant_01");

--  - Viết câu lệnh xóa các nhật ký xử lý bồi thường (Claim_Processing_Log) được ghi nhận trước ngày 20/6/2025.
delete from Claim_Processing_Log where Recorded_At < date("2025-06-20");

--  - Câu 1: Liệt kê thông tin các hợp đồng có trạng thái 'Active' và có ngày kết thúc trong năm 2026.
select * from Policies where Status = "Active" and year(End_Date) = 2026;

--  - Câu 2: Lấy thông tin khách hàng (Họ tên, Email) có tên chứa chữ 'Hoàng' và tham gia bảo hiểm từ năm 2025 trở lại đây.
select Full_Name,Email from customers where Full_Name like "%Hoàng%" and year(Join_Date) >= 2025 ;

--  - Câu 3: Hiển thị top 3 yêu cầu bồi thường (Claims) có số tiền được yêu cầu cao nhất, bỏ qua yêu cầu cao nhất (lấy từ vị trí số 2 đến số 4).
select * from Claims order by Claim_Amount desc limit 2,4;

