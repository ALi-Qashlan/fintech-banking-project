

select f.transaction_id

  from {{ ref('fct_transactions') }} as f

  join {{ ref('stg_accounts') }} as a
    on f.account_id = a.account_id

 where f.customer_id <> a.customer_id