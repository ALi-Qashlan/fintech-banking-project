select l.loan_id,
       l.customer_id,
       c.credit_score,
       l.loan_amount,
       cast(l.interest_rate as numeric(5,2)) as interest_rate,
       l.start_date,

       case
           when l.loan_amount >= 150000 then 'large'
           when l.loan_amount >= 75000 then 'medium'
           else 'small'
       end as loan_size_band

  from {{ ref('stg_loans') }} as l

  join {{ ref('stg_customers') }} as c
    on l.customer_id = c.customer_id