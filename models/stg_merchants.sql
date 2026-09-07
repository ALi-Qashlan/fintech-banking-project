select merchant_id,
       merchant_name,
       city

  from {{ source('banking', 'merchants') }}      