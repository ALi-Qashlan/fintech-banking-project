select c.customer_id,
       c.first_name,
       c.last_name,
       c.email,
       c.city,
       c.credit_score,
       c.created_at,

       coalesce(a.account_count, 0) as account_count,
       coalesce(a.distinct_account_type_count, 0) as distinct_account_type_count,
       coalesce(a.total_balance_usd, 0) as total_balance_usd,
       a.first_account_open_date,
       coalesce(a.has_checking_account, 0) as has_checking_account,
       coalesce(a.has_savings_account, 0) as has_savings_account,
       coalesce(a.has_business_account, 0) as has_business_account,

       coalesce(cd.card_count, 0) as card_count,
       coalesce(cd.distinct_card_type_count, 0) as distinct_card_type_count,
       coalesce(cd.has_debit_card, 0) as has_debit_card,
       coalesce(cd.has_credit_card, 0) as has_credit_card,

       coalesce(l.loan_count, 0) as loan_count,
       {{ to_binary_flag("coalesce(l.loan_count, 0) > 0") }} as has_loan,
       coalesce(l.total_loan_exposure_usd, 0) as total_loan_exposure_usd,
       l.average_loan_amount_usd,
       l.max_loan_amount_usd,
       l.average_interest_rate,
       l.first_loan_start_date,
       l.latest_loan_start_date,

       coalesce(t.transaction_count, 0) as transaction_count,
       coalesce(t.total_transaction_volume_usd, 0) as total_transaction_volume_usd,
       t.average_transaction_amount_usd,
       t.first_transaction_at,
       t.last_transaction_at,

       {{ to_binary_flag("coalesce(a.account_count, 0) > 0") }}
       +
       {{ to_binary_flag("coalesce(cd.card_count, 0) > 0") }}
       +
       {{ to_binary_flag("coalesce(l.loan_count, 0) > 0") }}
       as product_category_count,

       coalesce(a.has_checking_account, 0)
       + coalesce(a.has_savings_account, 0)
       + coalesce(a.has_business_account, 0)
       + coalesce(cd.has_debit_card, 0)
       + coalesce(cd.has_credit_card, 0)
       +
       {{ to_binary_flag("coalesce(l.loan_count, 0) > 0") }}
       as product_type_count

  from {{ ref('stg_customers') }} as c

  left join {{ ref('int_customer_accounts') }} as a
    on c.customer_id = a.customer_id

  left join {{ ref('int_customer_cards') }} as cd
    on c.customer_id = cd.customer_id

  left join {{ ref('int_customer_loans') }} as l
    on c.customer_id = l.customer_id

  left join {{ ref('int_customer_transactions') }} as t
    on c.customer_id = t.customer_id