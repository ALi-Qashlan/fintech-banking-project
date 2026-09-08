with months as (

    {{ dbt_utils.date_spine(
         datepart="month",
         start_date="cast('2019-01-01' as date)",
         end_date="cast('2026-01-01' as date)"
    ) }}

)

select date_month as quarter_start_date

  from months

 where extract(month from date_month) in (1, 4, 7, 10)