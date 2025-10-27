{{ config(materialized='table') }}

select
    event_id,
    event_timestamp::timestamp_ntz as login_time,
    user_name,
    client_ip,
    is_success,
    error_message
from snowflake.account_usage.login_history
where event_timestamp >= dateadd('day', -90, current_timestamp())