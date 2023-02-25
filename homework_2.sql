create database if not exists homework_5_2;
use homework_5_2;

drop table if exists time_table;
create table if not exists time_table
(
    id           int,
    station      varchar(20),
    time_arrival time
);

insert into time_table
values (110, 'San Francisco', '10:00:00'),
       (110, 'Redwood City', '10:54:00'),
       (110, 'Paolo Alto', '11:02:00'),
       (110, 'San Jose', '12:35:00'),
       (120, 'San Francisco', '11:00:00'),
       (120, 'Paolo Alto', '12:49:00'),
       (120, 'San Jose', '13:30:30');

select *
from time_table;

/*
 Добавьте новый столбец под названием «время до следующей станции».
 Чтобы получить это значение, мы вычитаем время станций для пар смежных станций.
 Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно.
 Проще это сделать с помощью оконной функции LEAD.
 Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат.
 В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее
 */

select *,
       timediff(lead(time_arrival) over (partition by id), time_table.time_arrival) as time_to_next_station
from time_table;
