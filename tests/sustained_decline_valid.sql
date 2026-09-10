select *
  from {{ ref('customer_engagement_trends') }}

 where engagement_trend = 'sustained_decline'
   and (
       latest_engagement_direction <> 'declining'
       or previous_engagement_direction <> 'declining'
   )