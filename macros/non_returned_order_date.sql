{%- macro non_returned_order_date(variable='min') %}
  {{variable}}(case when orders.status NOT IN ('returned','return_pending') then order_date end)
{% endmacro -%}