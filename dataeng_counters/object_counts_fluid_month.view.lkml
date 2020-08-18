view: object_counts_fluid_month {
  derived_table: {
    sql: select
        etl_ds,
        sum(unique_objects) as unique_objects,
        sum(persisted_objects) as persisted_objects
      from main_prod.dataeng_counters_history.source_unique_object_counts_fluid
      group by etl_ds
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

  dimension: unique_objects {
    type: number
    sql: ${TABLE}."UNIQUE_OBJECTS" ;;
  }

  dimension: persisted_objects {
    type: number
    sql: ${TABLE}."PERSISTED_OBJECTS" ;;
  }

  set: detail {
    fields: [etl_ds, unique_objects, persisted_objects]
  }
}
