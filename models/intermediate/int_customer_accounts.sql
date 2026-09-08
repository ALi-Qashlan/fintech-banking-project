select customer_id,
       count(account_id) as account_count,
       count(distinct account_type) as distinct_account_type_count,
       sum(balance_usd) as total_balance_usd,
       min(open_date) as first_account_open_date,
       max(
           case
               when account_type = 'Checking' then 1
               else 0
           end 
       ) as has_checking_account,
       max(
           case
               when account_type = 'Savings' then 1
               else 0
           end 
       ) as has_savings_account,
       max(
           case
               when account_type = 'Business' then 1
               else 0
           end
       ) as has_business_account         




  from {{ ref('stg_accounts') }}
 group by customer_id 