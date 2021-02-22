view: functions_destinations_counts_by_day {
  derived_table: {
    sql: SELECT
          DATE(HOUR) AS DAY,
          COUNT(DISTINCT WORKSPACE_ID) AS UNIQUE_WORKSPACES,
          SUM(INVOCATION_COUNT) AS INVOCATION_COUNT,
          SUM(ERROR_COUNT) AS ERROR_COUNT,
          SUM(THROTTLE_COUNT) AS THROTTLE_COUNT
      FROM "MAIN_PROD"."DATAENG_COUNTERS_HISTORY"."FUNCTIONS_DESTINATIONS_HOURLY"
      GROUP BY DATE(HOUR)
      ORDER BY DATE(HOUR) ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: day {
    type: date
    sql: ${TABLE}."DAY" ;;
  }

  dimension: unique_workspaces {
    type: number
    sql: ${TABLE}."UNIQUE_WORKSPACES" ;;
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

  set: detail {
    fields: [day, unique_workspaces, invocation_count, error_count, throttle_count]
  }
}
