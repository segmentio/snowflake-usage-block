view: event_counts_cumulative_api_calls {
  derived_table: {
    sql:
    WITH api_calls_current_month as (
      SELECT
        DATE_TRUNC(month, etl_ds) as month,
        date_part(day, etl_ds) as day,
        SUM(api_calls) as api_calls
      FROM main_prod.dataeng_counters_history.source_api_calls_daily
      WHERE DATE_TRUNC('month',etl_ds)  >= DATE_TRUNC('month',ADD_MONTHS((current_date - INTERVAL '1 day'),-12))
      GROUP BY date_part(day, etl_ds), DATE_TRUNC(month, etl_ds)
    )

    SELECT
      *,
      sum(api_calls) over (partition by month order by day asc rows between unbounded preceding and current row) as cumulative_api_calls
    FROM api_calls_current_month
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: month {
    type: date
    sql: ${TABLE}."MONTH" ;;
  }

  dimension: day {
    type: number
    sql: ${TABLE}."DAY" ;;
  }

  dimension: api_calls {
    type: number
    sql: ${TABLE}."API_CALLS" ;;
  }

  dimension: cumulative_api_calls {
    type: number
    sql: ${TABLE}."CUMULATIVE_API_CALLS" ;;
  }

  set: detail {
    fields: [month, day, api_calls, cumulative_api_calls]
  }
}
