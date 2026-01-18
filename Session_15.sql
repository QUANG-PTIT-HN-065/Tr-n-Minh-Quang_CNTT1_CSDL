drop database if exists mini_social_network;
create database mini_social_network;
use mini_social_network;
create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null unique,
    password varchar(255) not null,
    email varchar(100) not null unique,
    created_at datetime default current_timestamp
);

create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id) on delete cascade
);

create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id) on delete cascade,
    foreign key (user_id) references users(user_id) on delete cascade
);

create table likes (
    user_id int not null,
    post_id int not null,
    created_at datetime default current_timestamp,
    primary key (user_id, post_id),
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

create table friends (
    user_id int not null,
    friend_id int not null,
    status varchar(20) default 'pending',
    created_at datetime default current_timestamp,
    primary key (user_id, friend_id),
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (friend_id) references users(user_id) on delete cascade,
    check (status in ('pending','accepted'))
);


create table user_log (
    log_id int auto_increment primary key,
    user_id int,
    action varchar(50),
    log_time datetime default current_timestamp
);

create table post_log (
    log_id int auto_increment primary key,
    post_id int,
    user_id int,
    action varchar(50),
    log_time datetime default current_timestamp
);

create table like_log (
    log_id int auto_increment primary key,
    user_id int,
    post_id int,
    action varchar(50),
    log_time datetime default current_timestamp
);

create table friend_log (
    log_id int auto_increment primary key,
    user_id int,
    friend_id int,
    action varchar(50),
    log_time datetime default current_timestamp
);

delimiter //

create procedure sp_register_user(
    in p_username varchar(50),
    in p_password varchar(255),
    in p_email varchar(100)
)
begin
    if exists (select 1 from users where username = p_username) then
        signal sqlstate '45000' set message_text = 'username da ton tai';
    elseif exists (select 1 from users where email = p_email) then
        signal sqlstate '45000' set message_text = 'email da ton tai';
    else
        insert into users(username, password, email)
        values (p_username, p_password, p_email);
    end if;
end//

create trigger trg_after_register
after insert on users
for each row
begin
    insert into user_log(user_id, action)
    values (new.user_id, 'register');
end//

create procedure sp_create_post(
    in p_user_id int,
    in p_content text
)
begin
    if p_content is null or length(trim(p_content)) = 0 then
        signal sqlstate '45000' set message_text = 'noi dung rong';
    else
        insert into posts(user_id, content)
        values (p_user_id, p_content);
    end if;
end//

create trigger trg_after_post
after insert on posts
for each row
begin
    insert into post_log(post_id, user_id, action)
    values (new.post_id, new.user_id, 'create_post');
end//

alter table posts add column like_count int default 0;

create trigger trg_after_like
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;

    insert into like_log(user_id, post_id, action)
    values (new.user_id, new.post_id, 'like');
end//

create trigger trg_after_unlike
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;

    insert into like_log(user_id, post_id, action)
    values (old.user_id, old.post_id, 'unlike');
end//

create procedure sp_send_friend_request(
    in p_sender_id int,
    in p_receiver_id int
)
begin
    if p_sender_id = p_receiver_id then
        signal sqlstate '45000' set message_text = 'khong the tu ket ban';
    elseif exists (
        select 1 from friends 
        where user_id = p_sender_id and friend_id = p_receiver_id
    ) then
        signal sqlstate '45000' set message_text = 'da gui loi moi';
    else
        insert into friends(user_id, friend_id, status)
        values (p_sender_id, p_receiver_id, 'pending');
    end if;
end//

create trigger trg_after_friend_request
after insert on friends
for each row
begin
    insert into friend_log(user_id, friend_id, action)
    values (new.user_id, new.friend_id, 'send_request');
end//

create procedure sp_accept_friend(
    in p_user_id int,
    in p_friend_id int
)
begin
    start transaction;

    update friends
    set status = 'accepted'
    where user_id = p_friend_id
      and friend_id = p_user_id
      and status = 'pending';

    if row_count() = 0 then
        rollback;
        signal sqlstate '45000' set message_text = 'khong co loi moi';
    else
        insert ignore into friends(user_id, friend_id, status)
        values (p_user_id, p_friend_id, 'accepted');

        commit;
    end if;
end//

create procedure sp_remove_friend(
    in p_user_id int,
    in p_friend_id int
)
begin
    start transaction;

    delete from friends
    where (user_id = p_user_id and friend_id = p_friend_id)
       or (user_id = p_friend_id and friend_id = p_user_id);

    commit;
end//

create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    start transaction;

    if not exists (
        select 1 from posts 
        where post_id = p_post_id and user_id = p_user_id
    ) then
        rollback;
        signal sqlstate '45000' set message_text = 'khong co quyen xoa';
    else
        delete from posts where post_id = p_post_id;
        commit;
    end if;
end//

create procedure sp_delete_user(
    in p_user_id int
)
begin
    start transaction;

    delete from users where user_id = p_user_id;

    commit;
end//

delimiter ;
