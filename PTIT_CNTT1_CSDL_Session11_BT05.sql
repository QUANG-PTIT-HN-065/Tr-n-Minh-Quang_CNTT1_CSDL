use social_network_pro;

delimiter //

create procedure calculateuseractivityscore(
    in p_user_id int,
    out activity_score int,
    out activity_level varchar(50)
)
begin
    declare total_posts int;
    declare total_comments int;
    declare total_likes int;

    select count(*) into total_posts
    from posts
    where user_id = p_user_id;

    select count(*) into total_comments
    from comments
    where user_id = p_user_id;

    select count(l.user_id) into total_likes
    from posts p
    join likes l on p.post_id = l.post_id
    where p.user_id = p_user_id;

    set activity_score = total_posts * 10 + total_comments * 5 + total_likes * 3;

    if activity_score > 500 then
        set activity_level = 'rat tich cuc';
    elseif activity_score >= 200 then
        set activity_level = 'tich cuc';
    else
        set activity_level = 'binh thuong';
    end if;
end//

delimiter ;

call calculateuseractivityscore(1, @score, @level);
select @score, @level;

drop procedure calculateuseractivityscore;
