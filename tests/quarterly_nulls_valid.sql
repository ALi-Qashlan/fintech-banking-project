select *
  from {{ ref('int_customer_quarterly_activity') }}
 where transaction_count = 0
   and (
        average_transaction_amount_usd is not null
        or first_transaction_at is not null
        or last_transaction_at is not null
       )