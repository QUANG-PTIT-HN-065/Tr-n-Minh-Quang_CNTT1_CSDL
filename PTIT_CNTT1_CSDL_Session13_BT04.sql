use trigger_social;

create table if not exists post_history (
    history_id int auto_increment primary key,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    foreign key (post_id) references posts(post_id) on delete cascade
);

delimiter //

drop trigger if exists trg_before_update_posts//

create trigger trg_before_update_posts
before update on posts
for each row
begin
    if old.content <> new.content then
        insert into post_history (
            post_id,
            old_content,
            new_content,
            changed_at,
            changed_by_user_id
        )
        values (
            old.post_id,
            old.content,
            new.content,
            now(),
            old.user_id
        );
    end if;
end//

delimiter ;

update posts
set content = 'noi dung da duoc chinh sua lan 1'
where post_id = 1;

update posts
set content = 'noi dung da duoc chinh sua lan 2'
where post_id = 1;

update posts
set content = 'noi dung moi cho bai viet 3'
where post_id = 3;

select * from post_history;

insert into likes (user_id, post_id) values (2, 1);
insert into likes (user_id, post_id) values (3, 1);

select post_id, like_count from posts where post_id = 1;

update posts
set content = 'cap nhat noi dung khong anh huong like'
where post_id = 1;

select post_id, like_count from posts where post_id = 1;
select * from user_statistics;
