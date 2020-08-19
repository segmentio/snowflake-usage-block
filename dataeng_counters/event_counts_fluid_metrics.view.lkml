view: event_counts_fluid_metrics {
  derived_table: {
    sql:
      select
      etl_ds,
      count(distinct workspace_id) workspaces_with_mtu,
      count(distinct case when etl_ds = billing_period_end then workspace_id else null end ) as invoices_closed_today,
      count(distinct source_id) sources_with_mtu
      from
      main_prod.dataeng_counters_history.source_mtu_fluid
      where etl_ds >= current_date - interval '2 day'
      and (identified_users > 0 or anonymous_users > 0)
      group by etl_ds
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: workspaces_with_mtu {
    type: number
    sql: ${TABLE}."WORKSPACES_WITH_MTU" ;;
  }

  dimension: etl_ds {
    type: date
    sql:  ${TABLE}."ETL_DS" ;;
  }


  dimension: sources_with_mtu {
    type: number
    sql: ${TABLE}."SOURCES_WITH_MTU" ;;
  }

  dimension: invoices_closed_today {
    type: number
    sql: ${TABLE}."INVOICES_CLOSED_TODAY" ;;
  }

  set: detail {
    fields: [workspaces_with_mtu, invoices_closed_today]
  }
}
