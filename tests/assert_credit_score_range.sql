select *

  from {{ ref('stg_customers') }}

 where credit_score < 300
    or credit_score > 850