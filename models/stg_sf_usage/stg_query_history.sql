{{ config(materialized='table') }}

select
    query_id,
    warehouse_id,
    warehouse_name,
    user_name,
    role_name,
    database_name,
    schema_name,
    start_time::timestamp_ntz as start_time,
    end_time::timestamp_ntz as end_time,
    datediff('second', start_time, end_time) as query_duration_sec,
    bytes_scanned,
    error_code,
    error_message,
    query_tag
from snowflake.account_usage.query_history
where start_time >= dateadd('day', -90, current_timestamp())