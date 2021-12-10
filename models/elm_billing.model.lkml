connection: "elm_billing"

# include all the views
include: "/views/**/*.view"

datagroup: elm_billing_default_datagroup {
  sql_trigger: SELECT FLOOR((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) / (4*60*60));;
  max_cache_age: "1 hour"
}

persist_with: elm_billing_default_datagroup

explore: compute_others_details {
  persist_with: elm_billing_default_datagroup
}

explore: connection_reg_r3 {}

explore: storage_details {
  persist_with: elm_billing_default_datagroup
}

explore: compute_engine_details_v2 {
  persist_with: elm_billing_default_datagroup
}

explore: compute_engine_details {
  persist_with: elm_billing_default_datagroup
}

explore: storage_details_v2 {
  persist_with: elm_billing_default_datagroup
}
