select t.transaction_id,
       t.account_id,
       a.customer_id,
       t.merchant_id,
       t.amount_usd,
       t.transaction_at

  from {{ ref('stg_transactions') }} as t

  join {{ ref('stg_accounts') }} as a

    on t.account_id = a.account_id