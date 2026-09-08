with customer_quarters as (

    select a.customer_id,
           q.quarter_start_date

      from {{ ref('int_customer_accounts') }} as a

      cross join {{ ref('int_quarters') }} as q

     where q.quarter_start_date >= date_trunc('quarter', a.first_account_open_date)

),

quarterly_transactions as (

    select a.customer_id,

           date_trunc('quarter', t.transaction_at) as quarter_start_date,

           count(t.transaction_id) as transaction_count,

           sum(t.amount_usd) as total_transaction_volume_usd,

           avg(t.amount_usd) as average_transaction_amount_usd,

           min(t.transaction_at) as first_transaction_at,

           max(t.transaction_at) as last_transaction_at

      from {{ ref('stg_transactions') }} as t

      join {{ ref('stg_accounts') }} as a

        on t.account_id = a.account_id

     group by a.customer_id,
              date_trunc('quarter', t.transaction_at)

),

final as (

    select cq.customer_id,
           cq.quarter_start_date,

           coalesce(qt.transaction_count, 0) as transaction_count,

           coalesce(qt.total_transaction_volume_usd, 0) as total_transaction_volume_usd,

           qt.average_transaction_amount_usd,

           qt.first_transaction_at,

           qt.last_transaction_at

      from customer_quarters as cq

      left join quarterly_transactions as qt

        on cq.customer_id = qt.customer_id
       and cq.quarter_start_date = qt.quarter_start_date

)

select *
  from final