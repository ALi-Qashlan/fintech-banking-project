select *
  from {{ ref('int_customer_quarterly_activity') }}
 where transaction_count < 0
    or total_transaction_volume_usd < 0