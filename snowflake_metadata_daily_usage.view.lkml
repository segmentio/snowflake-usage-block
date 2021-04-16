view: snowflake_metadata_daily_usage {
  derived_table: {
    sql: select *
    from main_prod.snowflake_metadata.daily_table_aggregate
    where
      schema_table_name not like '% %'
      and schema_table_name not like '%=%'
      and schema_table_name not like '%@%'
  ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: query_date {
    type: date
    sql: ${TABLE}."QUERY_DATE" ;;
  }

  dimension: schema_table_name {
    type: string
    sql: ${TABLE}."SCHEMA_TABLE_NAME" ;;
  }

  dimension: user_name {
    type: string
    sql: ${TABLE}."USER_NAME" ;;
  }

  measure: query_count {
    type: sum
    sql: ${TABLE}."QUERY_COUNT" ;;
  }

  set: detail {
    fields: [query_date, schema_table_name, user_name, query_count]
  }
}
