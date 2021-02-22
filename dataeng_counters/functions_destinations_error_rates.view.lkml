view: functions_destinations_error_rates {
  derived_table: {
    sql: SELECT
          DATE(HOUR) AS DAY,
          functions_destinations_hourly.workspace_id || ' (' || slug || ') ' AS WORKSPACE,
          SUM(INVOCATION_COUNT) AS INVOCATION_COUNT,
          SUM(ERROR_COUNT) AS ERROR_COUNT,
          SUM(ERROR_COUNT) / SUM(INVOCATION_COUNT) AS ERROR_RATE
      FROM "MAIN_PROD"."DATAENG_COUNTERS_HISTORY"."FUNCTIONS_DESTINATIONS_HOURLY"
      LEFT OUTER JOIN main_prod.ctlplane.workspaces_lifetime on workspaces_lifetime.id = functions_destinations_hourly.workspace_id
      where DATE(HOUR) = current_date - interval '1 day'
      GROUP BY 1, 2 HAVING SUM(INVOCATION_COUNT) > 100
      ORDER BY 5 DESC
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

  dimension: invocation_count {
    type: number
    sql: ${TABLE}."INVOCATION_COUNT" ;;
  }

  dimension: error_count {
    type: number
    sql: ${TABLE}."ERROR_COUNT" ;;
  }

  dimension: error_rate {
    type: number
    sql: ${TABLE}."ERROR_RATE" ;;
  }

  set: detail {
    fields: [day, workspace, invocation_count, error_count, error_rate]
  }
}
