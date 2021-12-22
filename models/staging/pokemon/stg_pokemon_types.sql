select
index,
type
from {{source('pokemons', 'pokemon_types')}}