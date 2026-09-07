select card_id,
       account_id,
       card_type,
       expiration_date

  from {{ source('banking', 'cards') }} 
       