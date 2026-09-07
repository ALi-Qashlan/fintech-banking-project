select customer_id,
       first_name,
       last_name,
       email,
       city,
       credit_score,
       created_at

  from {{ source('banking', 'customers') }}