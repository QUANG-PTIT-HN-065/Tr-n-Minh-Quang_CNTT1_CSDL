use social_network_pro;

delimiter //

create procedure createpostwithvalidation(
    in p_user_id int,
    in p_content text,
    out result_message varchar(255)
)
begin
    if char_length(p_content) < 5 then
        set result_message = 'noi dung qua ngan';
    else
        insert into posts(user_id, content)
        values (p_user_id, p_content);
        set result_message = 'them bai viet thanh cong';
    end if;
end//

delimiter ;

call createpostwithvalidation(1, 'hi', @msg1);
select @msg1;

call createpostwithvalidation(1, 'noi dung hop le', @msg2);
select @msg2;

drop procedure createpostwithvalidation;
