SELECT time, machine_id
FROM maintenance_activity
ORDER BY RAND()
LIMIT 10;

create index t_idx on maintenance_activity (machine_id, time);

with time_diffs as
(
    select
        t1.machine_id, TIME_TO_SEC(TIMEDIFF(t1.time, max(t2.time))) as diff
    from
        maintenance_activity as t1,
        maintenance_activity as t2
    where
        t1.machine_id = t2.machine_id and
        t2.time < t1.time
    group by t1.machine_id, t1.time
)

select machine_id, SEC_TO_TIME(AVG(diff))
from time_diffs
group by machine_id
order by machine_id;
