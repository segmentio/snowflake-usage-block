view: customer_dashboard_quick_search {
  derived_table: {
    sql: select * from main_prod.customer_dashboard.quick_search
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: received_at {
    type: time
    sql: ${TABLE}."RECEIVED_AT" ;;
  }

  dimension: context_page_referrer {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_REFERRER" ;;
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}."ANONYMOUS_ID" ;;
  }

  dimension: context_page_search {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_SEARCH" ;;
  }

  dimension: event_text {
    type: string
    sql: ${TABLE}."EVENT_TEXT" ;;
  }

  dimension: pathname {
    type: string
    sql: ${TABLE}."PATHNAME" ;;
  }

  dimension: query_id {
    type: string
    sql: ${TABLE}."QUERY_ID" ;;
  }

  dimension_group: uuid_ts {
    type: time
    sql: ${TABLE}."UUID_TS" ;;
  }

  dimension: context_library_name {
    type: string
    sql: ${TABLE}."CONTEXT_LIBRARY_NAME" ;;
  }

  dimension: context_page_title {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_TITLE" ;;
  }

  dimension: context_page_url {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_URL" ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}."EVENT" ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}."TIMESTAMP" ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: context_ip {
    type: string
    sql: ${TABLE}."CONTEXT_IP" ;;
  }

  dimension: context_library_version {
    type: string
    sql: ${TABLE}."CONTEXT_LIBRARY_VERSION" ;;
  }

  dimension: context_page_path {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_PATH" ;;
  }

  dimension: context_user_agent {
    type: string
    sql: ${TABLE}."CONTEXT_USER_AGENT" ;;
  }

  dimension_group: original_timestamp {
    type: time
    sql: ${TABLE}."ORIGINAL_TIMESTAMP" ;;
  }

  dimension_group: sent_at {
    type: time
    sql: ${TABLE}."SENT_AT" ;;
  }

  dimension: query_slug {
    type: string
    sql: ${TABLE}."QUERY_SLUG" ;;
  }

  dimension: context_locale {
    type: string
    sql: ${TABLE}."CONTEXT_LOCALE" ;;
  }

  dimension: query {
    type: string
    sql: COALESCE(${TABLE}."QUERY_ID",NULL,${TABLE}."QUERY_SLUG")  ;;
  }

  set: detail {
    fields: [
      id,
      received_at_time,
      context_page_referrer,
      anonymous_id,
      context_page_search,
      event_text,
      pathname,
      query_id,
      uuid_ts_time,
      context_library_name,
      context_page_title,
      context_page_url,
      event,
      timestamp_time,
      user_id,
      context_ip,
      context_library_version,
      context_page_path,
      context_user_agent,
      original_timestamp_time,
      sent_at_time,
      query_slug,
      context_locale,
      query
    ]
  }
}
