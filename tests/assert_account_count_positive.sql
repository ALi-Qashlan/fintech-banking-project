select *

  from {{ ref('int_customer_accounts') }}

 where account_count < 1