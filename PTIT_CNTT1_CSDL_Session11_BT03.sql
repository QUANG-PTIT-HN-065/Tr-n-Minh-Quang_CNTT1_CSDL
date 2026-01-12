use social_network_pro;

delimiter //

create procedure calculatebonuspoints(
    in p_user_id int,
    inout p_bonus_points int
)
begin
    declare total_posts int;

    select count(*) into total_posts
    from posts
    where user_id = p_user_id;

    if total_posts >= 20 then
        set p_bonus_points = p_bonus_points + 100;
    elseif total_posts >= 10 then
        set p_bonus_points = p_bonus_points + 50;
    end if;
end//

delimiter ;

set @bonus = 100;
call calculatebonuspoints(1, @bonus);
select @bonus;

drop procedure calculatebonuspoints;
