drop table if exists users;
create table users (
    email varchar(128),
    first_name varchar(128),
    last_name varchar(128),
    account_type enum('admin', 'regular'),
    CONSTRAINT pk PRIMARY KEY (email)
);

insert into users values
('john.smith@xyz.org', 'John', 'Smith', 'regular'),
('bob.carlsen@foo.bar', 'Bob', 'Carlsen', 'regular'),
('eddie.stevens@data.org', 'Eddie', 'Stevens', 'regular'),
('admin@boss.org', 'Admin', 'Boss', 'admin'),
('root@boss.org', 'Root', 'Chief', 'admin');

select email, first_name,
       last_name, account_type
from users
order by email;

select row_number() over () as rnum,
       email, first_name,
       last_name, account_type
from users
order by email;

select row_number() over (order by email) as rnum,
       email, first_name,
       last_name, account_type
from users
order by email;

select row_number() over (partition by account_type order by email) as rnum,
       email, first_name,
       last_name, account_type
from users
order by account_type, email;
