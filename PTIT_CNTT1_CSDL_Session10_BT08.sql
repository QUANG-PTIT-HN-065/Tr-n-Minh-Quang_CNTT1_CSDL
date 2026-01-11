use social_network_pro;

create index idx_user_gender
on users(gender);

create view view_popular_posts as
select
    p.post_id,
    u.username,
    p.content,
    count(distinct l.like_id) as like_count,
    count(distinct c.comment_id) as comment_count
from posts p
join users u on p.user_id = u.user_id
left join likes l on p.post_id = l.post_id
left join comments c on p.post_id = c.post_id
group by p.post_id, u.username, p.content;

select *
from view_popular_posts;

select
    post_id,
    username,
    content,
    like_count,
    comment_count,
    (like_count + comment_count) as total_interaction
from view_popular_posts
where (like_count + comment_count) > 10
order by total_interaction desc;
