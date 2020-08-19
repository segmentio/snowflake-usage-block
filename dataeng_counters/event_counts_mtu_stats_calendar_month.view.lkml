view: event_counts_mtu_stats_calendar_month {
  derived_table: {
    sql: select
        to_date(workspace_mtu_calendar_month.etl_ds) as day,
        workspace_mtu_calendar_month.workspace_id || ' (' || slug || ') ',
        sum(identified_users+anonymous_users) as classic_mtu,
        sum(api_calls) as api_calls,
        sum(api_calls) / sum(identified_users+anonymous_users)  as throughput
      from main_prod.dataeng_counters_history.workspace_mtu_calendar_month
      left outer join (
        select workspace_id, sum(api_calls) as api_calls
        from main_prod.dataeng_counters_history.source_api_calls_daily
        where date_trunc('month', etl_ds) = date_trunc('month', current_date - interval '1 day') and api_calls > 0
        group by 1
      ) api_calls on api_calls.workspace_id = workspace_mtu_calendar_month.workspace_id
      left outer join main_prod.ctlplane.workspaces_lifetime on id = workspace_mtu_calendar_month.workspace_id
      where workspace_mtu_calendar_month.etl_ds = current_date - interval '1 day'
      and (identified_users > 0 or identified_users > 0)
      group by 1,2
      order by 3 desc
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
    label: "WORKSPACE_MTU_CALENDAR_MONTH.WORKSPACE_ID || ' (' || SLUG || ') '"
    sql: ${TABLE}."WORKSPACE_MTU_CALENDAR_MONTH.WORKSPACE_ID || ' (' || SLUG || ') '" ;;
  }

  measure: classic_mtu {
    type: sum
    sql: ${TABLE}."CLASSIC_MTU" ;;
  }

  measure: api_calls {
    type: sum
    sql: ${TABLE}."API_CALLS" ;;
  }

  measure: throughput {
    type: sum
    sql: ${TABLE}."THROUGHPUT" ;;
  }

  set: detail {
    fields: [day, workspace, classic_mtu, api_calls, throughput]
  }
}
