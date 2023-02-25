create database if not exists homework_5_1;
use homework_5_1;
drop table if exists car;
create table if not exists car
(
    id       int,
    name_car varchar(20),
    cost     decimal
);

load data infile 'J:/Developer/SQL/Homeworks/homework_5/file_name.csv'
    into table car
    fields terminated by ','
    lines terminated by '\r\n'
    ignore 1 rows;

-- Создайте представление, в которое попадут автомобили стоимостью  до 250 000 000 долларов
create view cheap_car as
select *
from car
where cost < 250000000;

select *
from cheap_car;

-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 300 000 000 долларов (используя оператор ALTER VIEW)
alter view cheap_car as
select *
from car
where car.cost < 300000000;

select *
from cheap_car;

-- Создайте представление, в котором будут только автомобили марки “BMW” и “Ауди”

drop view if exists bmw_and_audi;
create view bmw_and_audi as
    select *
from car
where name_car like '%bmw%' or name_car like '%audi%';

select *
from bmw_and_audi;

