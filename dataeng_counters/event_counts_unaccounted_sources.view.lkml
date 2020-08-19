view: event_counts_unaccounted_sources {
  derived_table: {
    sql: select
      day,
      listagg(source_id) as sources,
      sum(api_calls) as api_calls
      from main_prod.dataeng_counters_history.source_api_calls_daily
      where workspace_id is null
      group by 1
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

  dimension: sources {
    type: string
    sql: ${TABLE}."SOURCES" ;;
  }

  dimension: api_calls {
    type: number
    sql: ${TABLE}."API_CALLS" ;;
  }

  set: detail {
    fields: [day, sources, api_calls]
  }
}
