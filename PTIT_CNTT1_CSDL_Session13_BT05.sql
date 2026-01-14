use trigger_social;

delimiter //

drop trigger if exists trg_before_insert_users//
drop procedure if exists add_user//

create trigger trg_before_insert_users
before insert on users
for each row
begin
    if new.email not like '%@%.%' then
        signal sqlstate '45000'
        set message_text = 'email khong hop le';
    end if;

    if new.username not regexp '^[a-zA-Z0-9_]+$' then
        signal sqlstate '45000'
        set message_text = 'username chua ky tu khong hop le';
    end if;
end//

create procedure add_user(
    in p_username varchar(50),
    in p_email varchar(100),
    in p_created_at date
)
begin
    insert into users (username, email, created_at)
    values (p_username, p_email, p_created_at);
end//

delimiter ;

call add_user('user_hople_1', 'user1@example.com', '2025-01-10');
call add_user('user_hople_2', 'user2@gmail.com', '2025-01-11');

call add_user('user-sai', 'usersai@gmail.com', '2025-01-12');
call add_user('usersai2', 'usersaiemail', '2025-01-13');

select * from users;
