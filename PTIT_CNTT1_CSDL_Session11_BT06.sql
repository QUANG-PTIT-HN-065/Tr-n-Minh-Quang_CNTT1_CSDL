use social_network_pro;

create table if not exists notifications (
    notification_id int auto_increment primary key,
    user_id int,
    type varchar(50),
    content varchar(255),
    created_at datetime default current_timestamp
);

delimiter //

create procedure notifyfriendsonnewpost(
    in p_user_id int,
    in p_content text
)
begin
    declare done int default 0;
    declare v_friend_id int;
    declare v_username varchar(50);
    declare v_post_id int;

    declare cur_friends cursor for
        select friend_id from friends
        where user_id = p_user_id and status = 'accepted'
        union
        select user_id from friends
        where friend_id = p_user_id and status = 'accepted';

    declare continue handler for not found set done = 1;

    select username into v_username
    from users
    where user_id = p_user_id;

    insert into posts(user_id, content)
    values (p_user_id, p_content);

    set v_post_id = last_insert_id();

    open cur_friends;

    read_loop: loop
        fetch cur_friends into v_friend_id;
        if done = 1 then
            leave read_loop;
        end if;

        if v_friend_id <> p_user_id then
            insert into notifications(user_id, type, content)
            values (
                v_friend_id,
                'new_post',
                concat(v_username, ' da dang mot bai viet moi')
            );
        end if;
    end loop;

    close cur_friends;

    select v_post_id as post_id;
end//

delimiter ;

call notifyfriendsonnewpost(1, 'day la bai viet moi');

select *
from notifications
order by created_at desc;

drop procedure notifyfriendsonnewpost;
