view: objects_unaccounted {
  derived_table: {
    sql: select
          etl_ds,
          count(*) as number_of_sources,
          processing_result,
          sum(objects),
          LISTAGG(distinct source_id, ' , ') as sources
      from main_prod.dataeng_counters_history.source_object_counts_daily
      where workspace_id is null
      group by etl_ds, processing_result
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

  dimension: number_of_sources {
    type: number
    sql: ${TABLE}."NUMBER_OF_SOURCES" ;;
  }

  dimension: processing_result {
    type: string
    sql: ${TABLE}."PROCESSING_RESULT" ;;
  }

  dimension: sources {
    type: string
    sql: ${TABLE}."SOURCES" ;;
  }

  dimension: sumobjects {
    type: number
    sql: ${TABLE}."SUM(OBJECTS)" ;;
  }

  set: detail {
    fields: [etl_ds, number_of_sources, processing_result, sumobjects]
  }
}
