select customer_id,
       count(loan_id) as loan_count,
       sum(loan_amount) as total_loan_exposure_usd,
       avg(loan_amount) as average_loan_amount_usd,
       max(loan_amount) as max_loan_amount_usd,
       avg(interest_rate) as average_interest_rate,
       min(start_date) as first_loan_start_date,
       max(start_date) as latest_loan_start_date

  from {{ ref('stg_loans') }}

 group by customer_id        