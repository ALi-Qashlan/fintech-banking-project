select *

  from {{ ref('int_customer_loans') }}

 where max_loan_amount_usd < average_loan_amount_usd