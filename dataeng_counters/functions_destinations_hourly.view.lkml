view: functions_destinations_hourly {
  derived_table: {
    sql: select * from main_prod.dataeng_counters_history.functions_destinations_hourly
      where date(hour) >= current_date - interval '5 day'
      and workspace_id = 'YbzRgtcu6i'
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: workspace_id {
    type: string
    sql: ${TABLE}."WORKSPACE_ID" ;;
  }

  dimension: destination_id {
    type: string
    sql: ${TABLE}."DESTINATION_ID" ;;
  }

  dimension: function_id {
    type: string
    sql: ${TABLE}."FUNCTION_ID" ;;
  }

  dimension_group: hour {
    type: time
    sql: ${TABLE}."HOUR" ;;
  }

  dimension: invocation_count {
    type: number
    sql: ${TABLE}."INVOCATION_COUNT" ;;
  }

  dimension: error_count {
    type: number
    sql: ${TABLE}."ERROR_COUNT" ;;
  }

  dimension: throttle_count {
    type: number
    sql: ${TABLE}."THROTTLE_COUNT" ;;
  }

  dimension: execution_time_seconds {
    type: number
    sql: ${TABLE}."EXECUTION_TIME_SECONDS" ;;
  }

  dimension: etl_ds {
    type: date
    sql: ${TABLE}."ETL_DS" ;;
  }

  dimension_group: etl_ts {
    type: time
    sql: ${TABLE}."ETL_TS" ;;
  }

  dimension: etl_run_id {
    type: string
    sql: ${TABLE}."ETL_RUN_ID" ;;
  }

  set: detail {
    fields: [
      workspace_id,
      destination_id,
      function_id,
      hour_time,
      invocation_count,
      error_count,
      throttle_count,
      execution_time_seconds,
      etl_ds,
      etl_ts_time,
      etl_run_id
    ]
  }
}
