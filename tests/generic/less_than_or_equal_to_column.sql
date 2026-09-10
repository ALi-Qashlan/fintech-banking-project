{% test less_than_or_equal_to_column(model, column_name, compare_column) %}

select {{ column_name }},
       {{ compare_column }}

  from {{ model }}

 where {{ column_name }} > {{ compare_column }}

 {% endtest %}
       