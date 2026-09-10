select *
  from {{ ref('customer_relationship_summary') }}
 where product_category_count < 0
    or product_category_count > 3