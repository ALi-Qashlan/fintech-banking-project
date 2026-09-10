select *
  from {{ ref('customer_relationship_summary') }}
 where product_type_count < 0
    or product_type_count > 6