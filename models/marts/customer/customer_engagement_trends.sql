with quarterly_activity as (

    select customer_id,
           quarter_start_date,
           transaction_count,
           total_transaction_volume_usd

      from {{ ref('int_customer_quarterly_activity') }}

),

ranked_quarters as (

    select *,

           row_number() over (
               partition by customer_id
               order by quarter_start_date desc
           ) as quarter_recency_rank

      from quarterly_activity

),

recent_quarters as (

    select *

      from ranked_quarters

     where quarter_recency_rank <= 4

),

quarterly_comparisons as (

    select customer_id,
           quarter_start_date,
           quarter_recency_rank,
           transaction_count,
           total_transaction_volume_usd,

           lag(transaction_count) over (
               partition by customer_id
               order by quarter_start_date
           ) as previous_transaction_count,

           lag(total_transaction_volume_usd) over (
               partition by customer_id
               order by quarter_start_date
           ) as previous_transaction_volume_usd

      from recent_quarters

),

quarterly_direction as (

    select *,

           case
               when previous_transaction_count is null then null
               when transaction_count < previous_transaction_count then 'down'
               when transaction_count > previous_transaction_count then 'up'
               else 'same'
           end as transaction_count_direction,

           case
               when previous_transaction_volume_usd is null then null
               when total_transaction_volume_usd < previous_transaction_volume_usd then 'down'
               when total_transaction_volume_usd > previous_transaction_volume_usd then 'up'
               else 'same'
           end as transaction_volume_direction

      from quarterly_comparisons

),

combined_direction as (

    select *,

           case
               when previous_transaction_count is null then null

               when transaction_count_direction = 'down'
                and transaction_volume_direction = 'down'
                   then 'declining'

               when transaction_count_direction = 'up'
                and transaction_volume_direction = 'up'
                   then 'improving'

               when transaction_count = 0
                and previous_transaction_count = 0
                   then 'inactive'

               else 'mixed_or_stable'
           end as engagement_direction

      from quarterly_direction

),

customer_summary as (

    select customer_id,

           count(*) as quarters_observed,

           sum(
               case
                   when transaction_count > 0 then 1
                   else 0
               end
           ) as active_quarters_recent,

           sum(
               case
                   when transaction_count = 0 then 1
                   else 0
               end
           ) as zero_activity_quarters_recent,

           max(
               case
                   when quarter_recency_rank = 1 then transaction_count
               end
           ) as latest_transaction_count,

           max(
               case
                   when quarter_recency_rank = 2 then transaction_count
               end
           ) as previous_transaction_count,

           max(
               case
                   when quarter_recency_rank = 3 then transaction_count
               end
           ) as third_latest_transaction_count,

           max(
               case
                   when quarter_recency_rank = 1 then total_transaction_volume_usd
               end
           ) as latest_transaction_volume_usd,

           max(
               case
                   when quarter_recency_rank = 1 then engagement_direction
               end
           ) as latest_engagement_direction,

           max(
               case
                   when quarter_recency_rank = 2 then engagement_direction
               end
           ) as previous_engagement_direction

      from combined_direction

     group by customer_id

),

final as (

    select *,

           case
               when quarters_observed < 2
                   then 'insufficient_history'

               when quarters_observed >= 3
                and latest_transaction_count = 0
                and previous_transaction_count = 0
                and third_latest_transaction_count = 0
                    then 'persistently_inactive'

               when quarters_observed >= 3
                and latest_engagement_direction = 'declining'
                and previous_engagement_direction = 'declining'
                   then 'sustained_decline'

               when latest_engagement_direction = 'declining'
                   then 'recent_decline'

               when quarters_observed >= 3
                and latest_engagement_direction = 'improving'
                and previous_engagement_direction = 'improving'
                   then 'sustained_improvement'

               when latest_engagement_direction = 'improving'
                   then 'recent_improvement'

               else 'mixed_or_stable'
           end as engagement_trend

      from customer_summary

)

select *
  from final

