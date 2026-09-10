select *
  from {{ ref('customer_relationship_summary') }}
 where card_count > 0
   and account_count = 0