drop table if exists data_points;
create table data_points (
    time time,
    value float
);

insert into data_points values
('2016-09-01 10:00', 2),
('2016-09-01 11:00', 5),
('2016-09-01 12:00', 4),
('2016-09-01 13:00', 4),
('2016-09-01 14:00', 1),
('2016-09-01 15:00', 5),
('2016-09-01 15:00', 2),
('2016-09-01 15:00', 2);

select time, value,
       sum(value) over (order by time ROWS BETWEEN 1 PRECEDING
                                               AND 1 FOLLOWING) as sum
from data_points
order by time;

select time, value,
       sum(value) over (order by time ROWS BETWEEN 2 PRECEDING
                                               AND 2 FOLLOWING) as sum
from data_points
order by time;
