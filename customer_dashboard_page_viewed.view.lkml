view: customer_dashboard_page_viewed {
  derived_table: {
    sql: select * from main_prod.customer_dashboard.page_viewed
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

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension_group: original_timestamp {
    type: time
    sql: ${TABLE}."ORIGINAL_TIMESTAMP" ;;
  }

  dimension_group: sent_at {
    type: time
    sql: ${TABLE}."SENT_AT" ;;
  }

  dimension_group: uuid_ts {
    type: time
    sql: ${TABLE}."UUID_TS" ;;
  }

  dimension: context_page_path {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_PATH" ;;
  }

  dimension: context_user_agent {
    type: string
    sql: ${TABLE}."CONTEXT_USER_AGENT" ;;
  }

  dimension: context_page_referrer {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_REFERRER" ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}."SLUG" ;;
  }

  dimension: _id {
    type: string
    sql: ${TABLE}."_ID" ;;
  }

  dimension: context_ip {
    type: string
    sql: ${TABLE}."CONTEXT_IP" ;;
  }

  dimension: context_page_title {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_TITLE" ;;
  }

  dimension: event_text {
    type: string
    sql: ${TABLE}."EVENT_TEXT" ;;
  }

  dimension: page {
    type: string
    sql: ${TABLE}."PAGE" ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}."TIMESTAMP" ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}."ANONYMOUS_ID" ;;
  }

  dimension: context_library_name {
    type: string
    sql: ${TABLE}."CONTEXT_LIBRARY_NAME" ;;
  }

  dimension: context_page_url {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_URL" ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}."EVENT" ;;
  }

  dimension: context_library_version {
    type: string
    sql: ${TABLE}."CONTEXT_LIBRARY_VERSION" ;;
  }

  dimension: context_page_search {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_SEARCH" ;;
  }

  dimension: search_term {
    type: string
    sql: ${TABLE}."SEARCH_TERM" ;;
  }

  dimension: context_locale {
    type: string
    sql: ${TABLE}."CONTEXT_LOCALE" ;;
  }

  set: detail {
    fields: [
      id,
      received_at_time,
      name,
      original_timestamp_time,
      sent_at_time,
      uuid_ts_time,
      context_page_path,
      context_user_agent,
      context_page_referrer,
      slug,
      _id,
      context_ip,
      context_page_title,
      event_text,
      page,
      timestamp_time,
      user_id,
      anonymous_id,
      context_library_name,
      context_page_url,
      event,
      context_library_version,
      context_page_search,
      search_term,
      context_locale
    ]
  }
}
