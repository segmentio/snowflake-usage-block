view: event_counts_top_mtu_calendar_month {
  derived_table: {
    sql: select
        to_date(workspace_mtu_calendar_month.etl_ds) as day,
        workspace_mtu_calendar_month.workspace_id || ' (' || slug || ') ',
        sum(identified_users+anonymous_users) as classic_mtu
      from main_prod.dataeng_counters_history.workspace_mtu_calendar_month
      left outer join main_prod.ctlplane.workspaces_lifetime on id = workspace_id
      where workspace_mtu_calendar_month.etl_ds = current_date - interval '1 day'
      group by 1,2
      order by 3 desc
      limit 20
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

  dimension: workspace_mtu_calendar_month_workspace_id_____slug___ {
    type: string
    label: "WORKSPACE_MTU_CALENDAR_MONTH.WORKSPACE_ID || ' (' || SLUG || ') '"
    sql: ${TABLE}."WORKSPACE_MTU_CALENDAR_MONTH.WORKSPACE_ID || ' (' || SLUG || ') '" ;;
  }

  dimension: classic_mtu {
    type: number
    sql: ${TABLE}."CLASSIC_MTU" ;;
  }

  set: detail {
    fields: [day, workspace_mtu_calendar_month_workspace_id_____slug___, classic_mtu]
  }
}
