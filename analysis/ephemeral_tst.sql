with numb as (select 2),
x as(
select * from {{ref('ephemeral1')}}
)
select * from x