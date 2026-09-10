select *
  from {{ ref('customer_engagement_trends') }}

 where quarters_observed < 1
    or quarters_observed > 4