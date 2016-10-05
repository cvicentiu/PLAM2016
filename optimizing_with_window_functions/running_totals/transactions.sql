drop table if exists transactions;

create table transactions (
    timestamp datetime,
    transaction_id int,
    customer_id int,
    amount float
);

insert into transactions values
('2016-09-01 10:00', 1, 1, 1000),
('2016-09-01 11:00', 2, 1, -200),
('2016-09-01 12:00', 3, 1, -600),
('2016-09-01 12:10', 4, 2,  300),
('2016-09-01 13:00', 5, 1,  400),
('2016-09-01 14:00', 6, 2,  500),
('2016-09-01 15:00', 7, 2,  400);

SELECT timestamp, transaction_id, customer_id, amount,
       (SELECT sum(amount)
        FROM transactions AS t2
        WHERE t2.customer_id = t1.customer_id AND
              t2.timestamp <= t1.timestamp) AS balance
FROM transactions AS t1
ORDER BY customer_id, timestamp;

SELECT timestamp, transaction_id, customer_id,
       sum(amount) OVER (PARTITION BY customer_id
                         ORDER BY timestamp
                         ROWS BETWEEN UNBOUNDED PRECEDING AND
                                      CURRENT ROW) AS balance
FROM transactions AS t1
ORDER BY customer_id, timestamp;

