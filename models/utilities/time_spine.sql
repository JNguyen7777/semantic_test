{{ config(
    materialized='table',
    schema='semantic_utils',
    alias='time_spine'
) }}

with hours as (
    select dateadd(hour, seq4(), '2020-01-01 00:00:00') as date_hour
    from table(generator(rowcount => 24 * 3650))  -- ~10 years of hours
)
select
    date_hour,
    date_trunc('day', date_hour) as date_day,
    date_trunc('week', date_hour) as week_start_date,
    date_trunc('month', date_hour) as month_start_date
from hours
where date_hour <= current_timestamp()
