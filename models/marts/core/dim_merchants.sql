with merchant_activity as (

    select merchant_id,

           count(transaction_id) as transaction_count,

           cast(
               sum(amount_usd) as numeric(20,2)
           ) as total_transaction_volume_usd,

           cast(
               avg(amount_usd) as numeric(12,2)
           ) as average_transaction_amount_usd,

           min(transaction_at) as first_transaction_at,

           max(transaction_at) as latest_transaction_at

      from {{ ref('stg_transactions') }}

     group by merchant_id

)

select m.merchant_id,
       m.merchant_name,
       m.city,

       coalesce(a.transaction_count, 0) as transaction_count,
       coalesce(a.total_transaction_volume_usd, 0) as total_transaction_volume_usd,
       a.average_transaction_amount_usd,
       a.first_transaction_at,
       a.latest_transaction_at

  from {{ ref('stg_merchants') }} as m

  left join merchant_activity as a
    on m.merchant_id = a.merchant_id