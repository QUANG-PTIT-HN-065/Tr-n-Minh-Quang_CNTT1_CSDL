drop database if exists trigger_social;
create database trigger_social;
use trigger_social;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts (
    post_id int auto_increment primary key,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    foreign key (user_id) references users(user_id) on delete cascade
);

create table likes (
    like_id int auto_increment primary key,
    user_id int,
    post_id int,
    liked_at datetime default now(),
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

insert into posts (user_id, content, created_at) values
(1, 'post 1 by alice', now()),
(1, 'post 2 by alice', now()),
(2, 'post 1 by bob', now()),
(3, 'post 1 by charlie', now());

drop view if exists user_statistics;

create view user_statistics as
select 
    u.user_id,
    u.username,
    u.post_count,
    ifnull(sum(p.like_count), 0) as total_likes
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.post_count;

drop trigger if exists trg_before_insert_likes;
drop trigger if exists trg_after_insert_likes;
drop trigger if exists trg_after_delete_likes;
drop trigger if exists trg_after_update_likes;

delimiter //

create trigger trg_before_insert_likes
before insert on likes
for each row
begin
    declare post_owner int;

    select user_id
    into post_owner
    from posts
    where post_id = new.post_id;

    if post_owner = new.user_id then
        signal sqlstate '45000'
        set message_text = 'khong duoc like bai viet cua chinh minh';
    end if;
end//

create trigger trg_after_insert_likes
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end//

create trigger trg_after_delete_likes
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end//

create trigger trg_after_update_likes
after update on likes
for each row
begin
    if old.post_id <> new.post_id then
        update posts
        set like_count = like_count - 1
        where post_id = old.post_id;

        update posts
        set like_count = like_count + 1
        where post_id = new.post_id;
    end if;
end//

delimiter ;

insert into likes (user_id, post_id) values (1, 1);

insert into likes (user_id, post_id) values (2, 1);

select post_id, like_count from posts where post_id = 1;

update likes
set post_id = 3
where user_id = 2 and post_id = 1
limit 1;

select post_id, like_count from posts where post_id in (1, 3);

delete from likes
where user_id = 2 and post_id = 3
limit 1;

select * from posts;
select * from user_statistics;
