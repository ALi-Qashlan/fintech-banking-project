

with merchant_totals as (

    select sum(transaction_count) as transaction_count,
           sum(total_transaction_volume_usd) as transaction_volume

      from {{ ref('dim_merchants') }}

),

transaction_totals as (

    select count(*) as transaction_count,
           sum(amount_usd) as transaction_volume

      from {{ ref('fct_transactions') }}

)

select *

  from merchant_totals

 cross join transaction_totals

 where merchant_totals.transaction_count
       <> transaction_totals.transaction_count

    or merchant_totals.transaction_volume
       <> transaction_totals.transaction_volume