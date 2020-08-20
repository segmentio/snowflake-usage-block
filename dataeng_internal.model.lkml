connection: "account_usage"

# include all the views
include: "*.view"

include: "dataeng_counters/*.view"

# include all the dashboards
include: "account_usage_dashboard.dashboard.lookml"

datagroup: snowflake_usage_block_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

named_value_format: conditional_to_millions {
  value_format: "[>=1000000]0,,\"M\";[>=1000]0,\"K\";0"
}

persist_with: snowflake_usage_block_default_datagroup

explore: login_history {
}

explore: query_history {
  join: databases {
    type: left_outer
    sql_on: ${query_history.database_name} = ${databases.database_name} ;;
    relationship: many_to_one
  }

#   join: schemata {
#     type: left_outer
#     sql_on: ${databases.id} = ${schemata.id} ;;
#     relationship: one_to_many
#   }
}

# explore: schemata {
#   join: databases {
#     type: left_outer
#     sql_on: ${schemata.database_id} = ${databases.id} ;;
#     relationship: many_to_one
#   }
# }

explore: load_history {
  fields: [ALL_FIELDS*,-tables.table_name,-tables.id]
  join: tables {
    sql_on: ${load_history.table_id} = ${tables.id} ;;
    relationship: many_to_one
  }
}

explore: storage_usage {}

explore: table_storage_metrics {}

explore: warehouse_metering_history {}

explore: athena_usage {}

explore: s3_cost {}

explore: aws_service_cost {}

explore: object_counts_calendar_month {}

explore: object_counts_daily {}

explore: object_counts_fluid_month {}

explore: objects_unaccounted {}


explore: event_counts_cumulative_api_calls {}

explore: event_counts_fluid_metrics {}

explore: event_counts_mtu_stats_calendar_month {}

explore: event_counts_mtu_fluid {}

explore: event_counts_mtu_calendar_month {}

explore: event_counts_unaccounted_sources {}

explore: event_counts_e2e_anonymous_users {}

explore: event_counts_e2e_api_calls {}

explore: event_counts_e2e_identified_users {}

# explore: columns {}
#
# explore: databases {}
#
# explore: file_formats {}
#
# explore: functions {}
#
# explore: referential_constraints {}
#
# explore: sequences {}
#
# explore: stages {}
#
# explore: table_constraints {}
#
# explore: table_storage_metrics {}
#
# explore: tables {}
#
# explore: views {}
