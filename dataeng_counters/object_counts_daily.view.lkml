view: object_counts_daily {
  derived_table: {
    sql: select
        etl_ds,
        processing_result,
        sum(objects) as objects
      from main_prod.dataeng_counters_history.source_object_counts_daily
      group BY
        etl_ds,
        processing_result
      order by etl_ds
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

  dimension: processing_result {
    type: string
    sql: ${TABLE}."PROCESSING_RESULT" ;;
  }

  dimension: objects {
    type: number
    sql: ${TABLE}."OBJECTS" ;;
  }

  set: detail {
    fields: [etl_ds, processing_result, objects]
  }
}
