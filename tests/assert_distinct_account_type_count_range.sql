select *

  from {{ ref('int_customer_accounts') }}

 where distinct_account_type_count < 1 
    or distinct_account_type_count > 3