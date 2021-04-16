view: snowflake_metadata_bi_slow_query {
  derived_table: {
    sql: select * from main_prod.snowflake_metadata.bi_slow_query_aggregate
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: query_date {
    type: date
    sql: ${TABLE}."QUERY_DATE" ;;
  }

  dimension: query_hash {
    type: string
    sql: ${TABLE}."QUERY_HASH" ;;
  }

  dimension: query_text {
    type: string
    sql: ${TABLE}."QUERY_TEXT" ;;
  }

  dimension: user_name {
    type: string
    sql: ${TABLE}."USER_NAME" ;;
  }

  measure: query_count {
    type: sum
    sql: ${TABLE}."QUERY_COUNT" ;;
  }

  measure: avg_execution_time {
    type: average
    sql: ${TABLE}."AVG_EXECUTION_TIME" ;;
  }

  set: detail {
    fields: [
      query_date,
      query_hash,
      query_text,
      user_name,
      query_count,
      avg_execution_time
    ]
  }
}
