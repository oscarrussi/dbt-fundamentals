with details as (
    select * from {{ ref('stg_pokemon_details')}}
),
evolutions as (
    select * from {{ ref('pokemon_evolutions')}}
),
chain as (
    select * from {{ ref('dim_pokemon_chain_evolutions')}}
)
SELECT d.index, d.name, ef.evolves_to, et.evolves_from, c.level1, c.level2, c.level3,
(case 
when d.name=c.level1
then 'level1'
when d.name=c.level2
then 'level2'
else 
'level3'
end
) as pokemon_level
FROM details as d
left join evolutions as ef
on d.name=ef.evolves_from
left join evolutions as et
on d.name=et.evolves_to
left join chain as c 
on d.name=c.level1 or d.name=c.level2 or d.name=c.level3