{{
  config(
    materialized = "incremental",
    unique_key='id',
    merge_update_columns = ['name']
  )
}}
select * from {{ref('persons')}} as p0

{% if is_incremental() %}
  where not exists(select * from {{this}} as p1 where p0.id=p1.id and p0.name=p1.name limit 1)
{% endif %}