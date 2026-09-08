select *

  from {{ ref('int_customer_transactions') }}

 where transaction_count < 1