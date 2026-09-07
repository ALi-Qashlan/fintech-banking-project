select *

  from {{ ref('stg_cards') }}

 where expiration_date < '2019-01-01'