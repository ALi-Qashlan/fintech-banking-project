select *

  from {{ ref('stg_loans') }}

 where loan_amount <= 0