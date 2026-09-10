-- tests/fct_loans_size_band_valid.sql

select *

  from {{ ref('fct_loans') }}

 where (loan_amount >= 150000 and loan_size_band <> 'large')
    or (loan_amount >= 75000 and loan_amount < 150000 and loan_size_band <> 'medium')
    or (loan_amount < 75000 and loan_size_band <> 'small')