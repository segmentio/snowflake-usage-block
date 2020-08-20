view: event_counts_e2e_api_calls {
  derived_table: {
    sql: WITH daily AS
        (SELECT etl_ds,
                SUM(api_calls) daily_api_calls
         FROM main_prod.dataeng_counters_history.source_api_calls_daily
         WHERE source_id IN ('LFsopML5Rc')
           AND etl_ds >= DATE_TRUNC('month', current_date())
         GROUP BY 1
         ORDER BY 1)

      select d.etl_ds,
      d.daily_api_calls,
      sum(d2.daily_api_calls) monthly_cumulative
      from daily d
      join daily d2
      on d.etl_ds >= d2.etl_ds
      group by 1,2
      order by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: etl_ds {
    type: date
    sql: ${TABLE}."ETL_DS" ;;
  }

  dimension: daily_api_calls {
    type: number
    sql: ${TABLE}."DAILY_API_CALLS" ;;
  }

  dimension: monthly_cumulative {
    type: number
    sql: ${TABLE}."MONTHLY_CUMULATIVE" ;;
  }

  set: detail {
    fields: [etl_ds, daily_api_calls, monthly_cumulative]
  }
}
