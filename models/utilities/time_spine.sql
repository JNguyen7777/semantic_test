{{ config(
    materialized='table',
    schema='semantic_utils',
    alias='time_spine'
) }}

-- Create a continuous daily date spine from 2020-01-01 to today
with date_generator as (
    select dateadd(day, seq4(), '2020-01-01') as date_day
    from table(generator(rowcount => 3650))
)
select
    date_day as date_day,
    date_trunc('week', date_day) as week_start_date,
    date_trunc('month', date_day) as month_start_date,
    year(date_day) as year_number,
    month(date_day) as month_number
from date_generator
where date_day <= current_date()
