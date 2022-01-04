with types as (
    select * from {{ ref('stg_pokemon_types')}}
),
abilities as (
    select * from {{ ref('stg_pokemon_abilities')}}
),
details as (
    select * from {{ ref('stg_pokemon_details')}}
),
evolutions as (
    select * from {{ ref('pokemon_evolutions')}}
)
SELECT d.index, d.name, d.height, d.weight, a.ability, t.type,
d.bmi, d.range_weight, d.range_bmi, d.range_height, ef.evolves_to, et.evolves_from
FROM details as d
inner join abilities as a 
on d.index=a.index
inner join types as t
on d.index=t.index
left join evolutions as ef
on d.name=ef.evolves_from
left join evolutions as et
on d.name=et.evolves_to
