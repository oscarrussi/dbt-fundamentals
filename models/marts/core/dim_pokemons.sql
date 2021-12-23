with types as (
    select * from {{ ref('stg_pokemon_types')}}
),
abilities as (
    select * from {{ ref('stg_pokemon_abilities')}}
),
details as (
    select * from {{ ref('stg_pokemon_details')}}
)
SELECT d.index, d.name, d.height, d.weight, a.ability, t.type,
d.bmi, d.range_weight, d.range_bmi, d.range_height
FROM details as d
inner join abilities as a 
on d.index=a.index
inner join types as t
on d.index=t.index