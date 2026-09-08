select *

  from {{ ref('int_customer_transactions') }}

 where first_transaction_at > last_transaction_at