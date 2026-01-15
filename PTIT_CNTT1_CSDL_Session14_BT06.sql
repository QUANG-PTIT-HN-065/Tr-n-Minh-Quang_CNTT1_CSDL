drop database if exists social_network;
create database social_network;
use social_network;

drop table if exists likes;
drop table if exists posts;
drop table if exists users;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null
);

create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    likes_count int default 0,
    foreign key (user_id) references users(user_id)
);

create table likes (
    like_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id),
    unique key unique_like (post_id, user_id)
);

insert into users (username) values
('alice'),
('bob');

insert into posts (user_id, content) values
(1, 'bai viet dau tien');

delimiter //

drop procedure if exists like_post//

create procedure like_post(
    in p_post_id int,
    in p_user_id int
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    insert into likes (post_id, user_id)
    values (p_post_id, p_user_id);

    update posts
    set likes_count = likes_count + 1
    where post_id = p_post_id;

    commit;
end//

delimiter ;

call like_post(1, 1);

select * from likes;
select post_id, likes_count from posts where post_id = 1;

call like_post(1, 1);

select * from likes;
select post_id, likes_count from posts where post_id = 1;
