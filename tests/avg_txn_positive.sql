select *

  from {{ ref('int_customer_transactions') }}

 where average_transaction_amount_usd <= 0