select loan_id,
       customer_id,
       loan_amount,
       interest_rate,
       start_date
  from {{ source('banking', 'loans') }}