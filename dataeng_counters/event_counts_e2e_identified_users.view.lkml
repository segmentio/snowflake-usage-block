view: event_counts_e2e_identified_users {
  derived_table: {
    sql: WITH monthly AS
        (SELECT ETL_DS,
                IDENTIFIED_USERS MONTHLY_IDENTIFIED_USERS
         FROM MAIN_PROD.DATAENG_COUNTERS_HISTORY.SOURCE_MTU_CALENDAR_MONTH
         WHERE source_id IN ('LFsopML5Rc')
           AND ETL_DS >= DATE_TRUNC('month', current_date())
         ORDER BY 1)


      SELECT m.etl_ds date,
             m.MONTHLY_IDENTIFIED_USERS - coalesce(m2.MONTHLY_IDENTIFIED_USERS,0) daily_identified_users,
             m.MONTHLY_IDENTIFIED_USERS monthly_cumulative
      FROM monthly m
      left join monthly m2
        ON m.etl_ds = m2.etl_ds + 1
      ORDER BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}."DATE" ;;
  }

  dimension: daily_identified_users {
    type: number
    sql: ${TABLE}."DAILY_IDENTIFIED_USERS" ;;
  }

  dimension: monthly_cumulative {
    type: number
    sql: ${TABLE}."MONTHLY_CUMULATIVE" ;;
  }

  set: detail {
    fields: [date, daily_identified_users, monthly_cumulative]
  }
}
