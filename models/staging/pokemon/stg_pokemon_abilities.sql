select
index,
ability
from {{source('pokemons', 'pokemon_abilities')}}