with merchant_volume as (

    select merchant_id,
           sum(amount_usd) as total_volume_usd

      from {{ ref('fct_transactions') }}

     group by merchant_id

),

ranked_merchants as (

    select merchant_id,
           total_volume_usd,

           sum(total_volume_usd) over () as overall_volume_usd,

           sum(total_volume_usd) over (
               order by total_volume_usd desc
               rows between unbounded preceding and current row
           ) as cumulative_volume_usd

      from merchant_volume

)

select merchant_id,
       total_volume_usd,
       total_volume_usd / overall_volume_usd
           as merchant_volume_share,
       cumulative_volume_usd / overall_volume_usd
           as cumulative_volume_share

  from ranked_merchants

 order by total_volume_usd desc