{{ config(materialized='table') }}

select
    warehouse_id,
    warehouse_name,
    start_time::timestamp_ntz as credit_start_time,
    end_time::timestamp_ntz as end_time,
    credits_used,
    credits_used_compute,
    credits_used_cloud_services
from snowflake.account_usage.warehouse_metering_history
where start_time >= dateadd('day', -90, current_timestamp())