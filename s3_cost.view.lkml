view: s3_cost {
  derived_table: {
    sql:
      select
        date(case when len(date) = 10 then date else null end) as day,
        category,
        sum(cast(cost as decimal)) as cost
      from main_prod.internal_etl_cloudhealth_staging.reports
      where
        split_part(id, '/', 1) = '2886218031930'
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

  measure: cost {
    type: sum
    sql: ${TABLE}."COST" ;;
    value_format:"$#.00;($#.00)"
  }

  set: detail {
    fields: [day, category, cost]
  }
}
