select *

  from {{ ref('int_customer_accounts') }}

 where distinct_account_type_count > account_count