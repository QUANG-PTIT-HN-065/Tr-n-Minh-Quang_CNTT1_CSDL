drop database Session_14;
create database Session_14;
use Session_14;

create table accounts (
    account_id int auto_increment primary key,
    account_name varchar(50),
    balance decimal(10,2)
);

insert into accounts (account_name, balance) values
('Nguyễn Văn An', 1000.00),
('Trần Thị Bảy', 500.00);

delimiter //

create procedure transfer_money(
    in from_account int,
    in to_account int,
    in amount decimal(10,2)
)
begin
    declare from_balance decimal(10,2);

    start transaction;

    select balance
    into from_balance
    from accounts
    where account_id = from_account
    for update;

    if from_balance >= amount then
        update accounts
        set balance = balance - amount
        where account_id = from_account;

        update accounts
        set balance = balance + amount
        where account_id = to_account;

        commit;
    else
        rollback;
    end if;
end//

delimiter ;

call transfer_money(1, 2, 200.00);

select * from accounts;

