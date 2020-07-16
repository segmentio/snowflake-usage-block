view: athena_usage {
  derived_table: {
    sql: select
        QUERY_ID,
        QUERY_TEXT,
        case
            when QUERY_TEXT like '%dataeng_counters_stage.apilogs_raw_stream%' then 'stage - apilogs'
            when QUERY_TEXT like '%dataeng_counters.apilogs_raw_stream%' then 'production - apilogs'
            when QUERY_TEXT like '%dataeng_counters_stage.object_tracking_raw_stream%' then 'stage - objects'
            when QUERY_TEXT like '%dataeng_counters.object_tracking_raw_stream%' then 'production - objects'
            else 'other'
        end as query_group,
        SUBMISSION_TIMESTAMP,
        COMPLETION_TIMESTAMP,
        STATE,
        DATA_SCANNED_IN_BYTES,
        ENGINE_EXECUTION_TIME_IN_MILLIS
      from MAIN_PROD.DATAENG_INTERNAL.ATHENA_QUERIES
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: query_id {
    type: string
    sql: ${TABLE}."QUERY_ID" ;;
  }

  dimension: query_text {
    type: string
    sql: ${TABLE}."QUERY_TEXT" ;;
  }

  dimension: query_group {
    type: string
    sql: ${TABLE}."QUERY_GROUP" ;;
  }

  dimension_group: submission_timestamp {
    type: time
    sql: ${TABLE}."SUBMISSION_TIMESTAMP" ;;
  }

  dimension_group: completion_timestamp {
    type: time
    sql: ${TABLE}."COMPLETION_TIMESTAMP" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: data_scanned_in_bytes {
    type: number
    sql: ${TABLE}."DATA_SCANNED_IN_BYTES" ;;
  }

  measure: engine_execution_time_in_millis {
    type: sum
    sql: ${TABLE}."ENGINE_EXECUTION_TIME_IN_MILLIS" ;;
  }

  measure: execution_cost {
    type: sum
    sql: ( ${TABLE}."ENGINE_EXECUTION_TIME_IN_MILLIS" / 1024 ) * 5 ;;
    value_format: "0.00"
    html: {{ rendered_value }}GB - ${{ rendered_value | divided_by: 1024 | times: 5 }} ;;
  }

  measure: data_scanned_in_gbs {
    type: sum
    sql: ${TABLE}."DATA_SCANNED_IN_BYTES" / 1073741824;;
    value_format: "0.00"
    html: {{ rendered_value }}GB - ${{ value | divided_by: 1024 | times: 5 }} ;;
  }

  set: detail {
    fields: [
      query_id,
      query_text,
      query_group,
      submission_timestamp_time,
      completion_timestamp_time,
      state,
      data_scanned_in_bytes,
      engine_execution_time_in_millis
    ]
  }
}
