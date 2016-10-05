select
    pk, machine_id, time
    lag(time) over (partition by machine_id order by time) as prev_time
from maintenance_activity;

with activity_diff as
(
    select
        pk, machine_id, time,
        lag(time) over (partition by machine_id order by time) as prev_time
    from maintenance_activity
)
select
    machine_id,
    SEC_TO_TIME(AVG(TIME_TO_SEC(TIMEDIFF(time, prev_time))))
from activity_diff
where not ISNULL(prev_time)
group by machine_id
order by machine_id, time;
