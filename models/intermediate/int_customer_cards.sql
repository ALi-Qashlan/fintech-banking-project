select a.customer_id,
       count(c.card_id) as card_count, 
       count(distinct c.card_type) as distinct_card_type_count,
       max(
           case
                when c.card_type = 'Debit' then 1
                else 0
           end
       ) as has_debit_card,
       max(
           case
                when c.card_type = 'Credit' then 1
                else 0
           end
       ) as has_credit_card       

  from {{ ref('stg_cards') }} as c
  join {{ ref('stg_accounts') }} as a

    on c.account_id = a.account_id

 group by a.customer_id