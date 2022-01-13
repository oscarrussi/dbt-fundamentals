{% set old_fct_orders_query %}
  select
    *
  from {{ref('customer_orders')}}
{% endset %}

{% set new_fct_orders_query %}
  select
    *
  from {{ref('au_customer_orders')}}
{% endset %}

{{ audit_helper.compare_queries(
    a_query=old_fct_orders_query,
    b_query=new_fct_orders_query,
    primary_key="order_id"
) }}