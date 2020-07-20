view: s3_cost_daily {
  derived_table: {
    sql: select * from cloudhealth.s3_cost where category in ('segment-data-lake-production', 'segment-data-lake-development', 'segment-data-lake-stage')
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: s3_cost_rr_storage {
    type: number
    sql: ${TABLE}."S3_COST_RR_STORAGE" ;;
  }

  dimension: s3_cost_transfer {
    type: number
    sql: ${TABLE}."S3_COST_TRANSFER" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}."ID" ;;
  }

  dimension: s3_cost_api {
    type: number
    sql: ${TABLE}."S3_COST_API" ;;
  }

  dimension: s3_cost_glacier_overhead {
    type: number
    sql: ${TABLE}."S3_COST_GLACIER_OVERHEAD" ;;
  }

  dimension: s3_cost_ia_storage {
    type: number
    sql: ${TABLE}."S3_COST_IA_STORAGE" ;;
  }

  dimension_group: uuid_ts {
    type: time
    sql: ${TABLE}."UUID_TS" ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}."DATE" ;;
  }

  dimension_group: received_at {
    type: time
    sql: ${TABLE}."RECEIVED_AT" ;;
  }

  dimension: s3_cost_glacier_storage {
    type: number
    sql: ${TABLE}."S3_COST_GLACIER_STORAGE" ;;
  }

  dimension: s3_cost_storage {
    type: number
    sql: ${TABLE}."S3_COST_STORAGE" ;;
  }

  dimension: s3_cost_total {
    type: number
    sql: ${TABLE}."S3_COST_TOTAL" ;;
  }

  set: detail {
    fields: [
      s3_cost_rr_storage,
      s3_cost_transfer,
      category,
      id,
      s3_cost_api,
      s3_cost_glacier_overhead,
      s3_cost_ia_storage,
      uuid_ts_time,
      date,
      received_at_time,
      s3_cost_glacier_storage,
      s3_cost_storage,
      s3_cost_total
    ]
  }
}
