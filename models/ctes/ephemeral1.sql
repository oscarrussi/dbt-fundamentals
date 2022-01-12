{{
  config(
    materialized = "ephemeral"
  )
}}

select name,
ROW_NUMBER() OVER(ORDER BY name) as number
 from {{ref('persons')}}