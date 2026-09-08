select *

  from {{ ref('int_customer_loans') }}

 where loan_count < 1