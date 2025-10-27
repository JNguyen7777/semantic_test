{{ config(materialized='view') }}

select
    usage_date::date as usage_date,
    database_name,
    avg(AVERAGE_DATABASE_BYTES + AVERAGE_FAILSAFE_BYTES) / pow(1024,3) as avg_storage_gb
from snowflake.account_usage.database_storage_usage_history
where usage_date >= dateadd('day', -90, current_date)
group by 1, 2