select *

  from {{ ref('int_customer_transactions') }}

 where total_transaction_volume_usd <= 0