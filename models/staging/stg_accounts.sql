select account_id,
       customer_id,
       account_type,
       balance_usd,
       open_date
           
  from {{ source('banking', 'accounts') }}
    
   