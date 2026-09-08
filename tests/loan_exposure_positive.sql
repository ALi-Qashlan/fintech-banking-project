select *

  from {{ ref('int_customer_loans') }}

 where total_loan_exposure_usd <= 0