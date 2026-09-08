select *

  from {{ ref('int_customer_cards') }}

 where card_count < 1
