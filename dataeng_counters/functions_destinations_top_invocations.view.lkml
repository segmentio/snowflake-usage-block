view: functions_destinations_top_invocations {
  derived_table: {
    sql: SELECT
          DATE(HOUR) AS DAY,
          functions_destinations_hourly.workspace_id || ' (' || slug || ') ' AS WORKSPACE,
          SUM(INVOCATION_COUNT) AS INVOCATION_COUNT
          --SUM(ERROR_COUNT) AS ERROR_COUNT,
      FROM "MAIN_PROD"."DATAENG_COUNTERS_HISTORY"."FUNCTIONS_DESTINATIONS_HOURLY"
      LEFT OUTER JOIN main_prod.ctlplane.workspaces_lifetime on workspaces_lifetime.id = functions_destinations_hourly.workspace_id
      where DATE(HOUR) = current_date - interval '1 day'
      GROUP BY 1, 2
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
    label: "WORKSPACE"
    sql: ${TABLE}.workspace ;;
  }

  dimension: invocation_count {
    type: number
    sql: ${TABLE}."INVOCATION_COUNT" ;;
  }

  set: detail {
    fields: [day, workspace, invocation_count]
  }
}
