select
    index
from {{ ref('stg_pokemon_abilities') }}
where ability=''