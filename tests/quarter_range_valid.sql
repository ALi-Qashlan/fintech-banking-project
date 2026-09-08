select *

  from {{ ref('int_quarters') }}

 where quarter_start_date < '2019-01-01'
    or quarter_start_date >= '2026-01-01'