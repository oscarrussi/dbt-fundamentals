with details as (
    select * from {{ ref('stg_pokemon_details')}}
),
evolutions as (
    select * from {{ ref('pokemon_evolutions')}}
),
levels1 as (
    select d1.name from details as d1 
    where (select count(*) from evolutions as e1 where e1.evolves_to=d1.name)=0
)
select levels1.name as level1, e2.evolves_to as level2, e3.evolves_to as level3 from levels1
left join evolutions as e2
on levels1.name=e2.evolves_from
left join evolutions as e3
on e2.evolves_to=e3.evolves_from