select *

  from {{ ref('int_customer_cards') }}

 where distinct_card_type_count < 1
    or distinct_card_type_count > 2