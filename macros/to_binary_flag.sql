{% macro to_binary_flag(expression) %}

case
    when {{ expression }} then 1
    else 0
end

{% endmacro %}