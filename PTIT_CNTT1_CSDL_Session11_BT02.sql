
use social_network_pro;;

delimiter //

create procedure calculatepostlikes(
    in p_post_id int,
    out total_likes int
)
begin
    select count(*) into total_likes
    from likes
    where post_id = p_post_id;
end//

delimiter ;

set @total_likes = 0;
call calculatepostlikes(1, @total_likes);
select @total_likes;

drop procedure calculatepostlikes;
