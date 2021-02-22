view: functions_destinations_execution_time {
  derived_table: {
    sql: SELECT
          DATE(HOUR) AS DAY,
          functions_destinations_hourly.workspace_id || ' (' || slug || ') ' AS WORKSPACE,
          SUM(EXECUTION_TIME_SECONDS) AS EXECUTION_TIME_SECONDS,
          SUM(INVOCATION_COUNT) AS INVOCATION_COUNT,
          SUM(EXECUTION_TIME_SECONDS) / SUM(INVOCATION_COUNT) AS AVG_EXE_TIME_PER_INVOCATION
      FROM "MAIN_PROD"."DATAENG_COUNTERS_HISTORY"."FUNCTIONS_DESTINATIONS_HOURLY"
      LEFT OUTER JOIN main_prod.ctlplane.workspaces_lifetime on workspaces_lifetime.id = functions_destinations_hourly.workspace_id
      where DATE(HOUR) = current_date - interval '1 day'
      GROUP BY 1, 2 HAVING SUM(INVOCATION_COUNT) > 100
      ORDER BY 3 DESC
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

  dimension: workspace {
    type: string
    sql: ${TABLE}."WORKSPACE" ;;
  }

  dimension: execution_time_seconds {
    type: number
    sql: ${TABLE}."EXECUTION_TIME_SECONDS" ;;
  }

  dimension: invocation_count {
    type: number
    sql: ${TABLE}."INVOCATION_COUNT" ;;
  }

  dimension: avg_exe_time_per_invocation {
    type: number
    sql: ${TABLE}."AVG_EXE_TIME_PER_INVOCATION" ;;
  }

  set: detail {
    fields: [day, workspace, execution_time_seconds, invocation_count, avg_exe_time_per_invocation]
  }
}
