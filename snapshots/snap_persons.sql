{% snapshot audit_persons %}
{{
    config(
      unique_key='id',
      target_schema='snapshots',
      strategy='check',
      check_cols=['id', 'name'],
    )
}}
select *  from {{ ref('persons') }}
{% endsnapshot %}