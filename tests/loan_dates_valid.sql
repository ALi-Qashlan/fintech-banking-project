select *

  from {{ ref('int_customer_loans') }}

 where first_loan_start_date > latest_loan_start_date