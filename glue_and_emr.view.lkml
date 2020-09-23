view: glue_and_emr {
  derived_table: {
    sql: select
        date(case when len(date) = 10 then date else null end) as day,
        category,
        sum(cast(cost as decimal)) as cost
      from main_prod.internal_etl_cloudhealth_staging.reports
      where
        split_part(id, '/', 1) = '2886218032312'
        and date > '2020-07-01'
        and date != 'total' and lower(category) != 'total'
      group by
        date(case when len(date) = 10 then date else null end),
        category
      having sum(cast(cost as decimal)) > 0
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

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  set: detail {
    fields: [day, category, cost]
  }
}
