select transaction_id,
       account_id,
       merchant_id,
       amount_usd,
       transaction_date as transaction_at

  from {{ source('banking', 'transactions') }}