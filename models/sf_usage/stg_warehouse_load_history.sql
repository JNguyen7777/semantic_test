{{ config(materialized='table') }}

select
    warehouse_id,
    warehouse_name,
    start_time::timestamp_ntz as start_time,
    end_time::timestamp_ntz as end_time,
    avg_running as running_queries,
    avg_queued_load as queued_load,
    avg_queued_provisioning as queued_provisioning
from snowflake.account_usage.warehouse_load_history
where start_time >= dateadd('day', -90, current_timestamp())