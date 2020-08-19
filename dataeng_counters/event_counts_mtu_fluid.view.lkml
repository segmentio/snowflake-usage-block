view: event_counts_mtu_fluid {
  derived_table: {
    sql: select
        to_date(etl_ds) as day,
        count(workspace_id),
        sum(identified_users) as identified_users,
        sum(anonymous_users) as anonymous_users
      from main_prod.dataeng_counters_history.workspace_mtu_fluid
      group by 1
      order by 1
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

  dimension: countworkspace_id {
    type: number
    sql: ${TABLE}."COUNT(WORKSPACE_ID)" ;;
  }

  dimension: identified_users {
    type: number
    sql: ${TABLE}."IDENTIFIED_USERS" ;;
  }

  dimension: anonymous_users {
    type: number
    sql: ${TABLE}."ANONYMOUS_USERS" ;;
  }

  set: detail {
    fields: [day, countworkspace_id, identified_users, anonymous_users]
  }
}
