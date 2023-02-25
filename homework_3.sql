-- выбрать всех пользователей, указав их id, имя и фамилию, город и аватарку
-- (используя вложенные запросы)

select id,
       concat(firstname, ' ', lastname)                                                                       as fillname,
       (select hometown from profiles where user_id = users.id)                                               as city,
       (select filename from media where media.id = (select photo_id from profiles where user_id = users.id)) as avatar
from users;

-- Список медиафайлов пользователей, указав название типа медиа (id, filename, name_type)
-- (используя JOIN)

select media.id,
       filename,
       name_type
from media
         left join media_types mt on media.media_type_id = mt.id;

-- Найдите друзей у  друзей пользователя с id = 1. 
-- (решение задачи с помощью представления “друзья”)

create view friend as
select *
from friend_requests
where initiator_user_id = 1
  and status = 'approved'
union
select *
from friend_requests
where target_user_id = 1
  and status = 'approved';

create view friend_1 as
select distinct id,
                concat(firstname, ' ', lastname) as friends
from users
         join friend on initiator_user_id = id or target_user_id = id
where id != 1;

-- Найдите друзей у друзей пользователя с id = 1 и поместите выборку в представление;
create view status_friend as
select *
from friend_1
         join friend_requests on id = initiator_user_id
where status = 'approved'
union
select *
from friend_1
         join friend_requests on id = target_user_id
where status = 'approved';

create or replace view friend_of_friends as
select status_friend.id,
       friends,
       concat(firstname, ' ', lastname) as friends_of_friends,
       initiator_user_id,
       target_user_id
from status_friend
         join users on initiator_user_id = users.id or target_user_id = users.id
where friends != concat(firstname, ' ', lastname)
