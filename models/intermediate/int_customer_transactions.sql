select a.customer_id,
       count(t.transaction_id_broken) as transaction_count,
       sum(t.amount_usd) as total_transaction_volume_usd,
       avg(t.amount_usd) as average_transaction_amount_usd,
       min(t.transaction_at) as first_transaction_at,
       max(t.transaction_at) as last_transaction_at

  from {{ ref('stg_transactions') }} as t
  join {{ ref('stg_accounts') }} as a       

  on t.account_id = a.account_id

 group by customer_id  