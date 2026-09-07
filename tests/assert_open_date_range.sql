select *

  from {{ ref('stg_accounts') }}

 where open_date < '2019-01-01'
    or open_date > '2025-12-31'