view: event_counts_unaccounted_usage {
  derived_table: {
    sql: select
      day,
      sum(api_calls)
      from main_prod.dataeng_counters_history.source_api_calls_daily
      where workspace_id is null
      group by day
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

  measure: api_calls {
    type: sum
    sql: ${TABLE}."SUM(API_CALLS)" ;;
  }

  set: detail {
    fields: [day, api_calls]
  }
}
