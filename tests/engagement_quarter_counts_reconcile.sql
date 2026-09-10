select *
  from {{ ref('customer_engagement_trends') }}

 where active_quarters_recent
       + zero_activity_quarters_recent
       <> quarters_observed