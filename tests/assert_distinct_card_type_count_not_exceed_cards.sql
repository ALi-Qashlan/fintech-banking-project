select *

  from {{ ref('int_customer_cards') }}

 where distinct_card_type_count > card_count