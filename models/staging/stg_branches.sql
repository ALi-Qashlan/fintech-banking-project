select branch_id,
       branch_name,
       manager_name,
       city,
       country

  from {{ source('banking', 'branches') }}