use social_network;

drop table if exists comments;

alter table posts
    add column comments_count int default 0;

create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

delimiter //

drop procedure if exists sp_post_comment//

create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    insert into comments(post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    savepoint after_insert;

    update posts
    set comments_count = comments_count + 1
    where post_id = p_post_id;

    if row_count() = 0 then
        rollback to after_insert;
        commit;
    else
        commit;
    end if;
end//

delimiter ;

call sp_post_comment(1, 1, 'binh luan hop le');

call sp_post_comment(999, 1, 'binh luan loi');

select * from comments;
select post_id, comments_count from posts;
