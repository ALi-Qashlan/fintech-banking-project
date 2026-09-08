select *

  from {{ ref('int_customer_loans') }}

 where average_loan_amount_usd <= 0