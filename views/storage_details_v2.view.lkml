view: storage_details_v2 {
  sql_table_name: `report.storage_details_v2`
    ;;

  dimension: apac_based_storage_egress_via_peered_interconnect_network {
    type: number
    sql: ${TABLE}.APAC_based_Storage_egress_via_peered_interconnect_network ;;
  }

  dimension: billing_name {
    type: string
    sql: ${TABLE}.billing_name ;;
  }

  dimension: bucket_name {
    type: string
    sql: ${TABLE}.bucket_name ;;
  }

  dimension: download_apac {
    type: number
    sql: ${TABLE}.Download_APAC ;;
  }

  dimension: download_australia {
    type: number
    sql: ${TABLE}.Download_Australia ;;
  }

  dimension: download_china {
    type: number
    sql: ${TABLE}.Download_China ;;
  }

  dimension: download_worldwide_destinations_excluding_asia_australia {
    type: number
    sql: ${TABLE}.Download_Worldwide_Destinations_excluding_Asia_Australia ;;
  }

  dimension: eu_based_storage_egress_via_peered_interconnect_network {
    type: number
    sql: ${TABLE}.EU_based_Storage_egress_via_peered_interconnect_network ;;
  }

  dimension: gcp_storage_egress_between_apac_and_sa {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_APAC_and_SA ;;
  }

  dimension: gcp_storage_egress_between_au_and_apac {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_AU_and_APAC ;;
  }

  dimension: gcp_storage_egress_between_au_and_eu {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_AU_and_EU ;;
  }

  dimension: gcp_storage_egress_between_au_and_na {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_AU_and_NA ;;
  }

  dimension: gcp_storage_egress_between_au_and_sa {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_AU_and_SA ;;
  }

  dimension: gcp_storage_egress_between_eu_and_apac {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_EU_and_APAC ;;
  }

  dimension: gcp_storage_egress_between_eu_and_sa {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_EU_and_SA ;;
  }

  dimension: gcp_storage_egress_between_na_and_apac {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_NA_and_APAC ;;
  }

  dimension: gcp_storage_egress_between_na_and_eu {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_NA_and_EU ;;
  }

  dimension: gcp_storage_egress_between_na_and_sa {
    type: number
    sql: ${TABLE}.GCP_Storage_egress_between_NA_and_SA ;;
  }

  dimension: inter_region_gcp_storage_egress_within_apac {
    type: number
    sql: ${TABLE}.Inter_region_GCP_Storage_egress_within_APAC ;;
  }

  dimension: inter_region_gcp_storage_egress_within_au {
    type: number
    sql: ${TABLE}.Inter_region_GCP_Storage_egress_within_AU ;;
  }

  dimension: inter_region_gcp_storage_egress_within_eu {
    type: number
    sql: ${TABLE}.Inter_region_GCP_Storage_egress_within_EU ;;
  }

  dimension: inter_region_gcp_storage_egress_within_na {
    type: number
    sql: ${TABLE}.Inter_region_GCP_Storage_egress_within_NA ;;
  }

  dimension: inter_region_gcp_storage_egress_within_sa {
    type: number
    sql: ${TABLE}.Inter_region_GCP_Storage_egress_within_SA ;;
  }

  dimension: invoice_month {
    type: string
    sql: ${TABLE}.invoice_month ;;
  }

  dimension: na_based_storage_egress_via_peered_interconnect_network {
    type: number
    sql: ${TABLE}.NA_based_Storage_egress_via_peered_interconnect_network ;;
  }

  dimension: network_price {
    type: number
    sql: ${TABLE}.NETWORK_PRICE ;;
  }

  dimension: networking_traffic_egress_gae_firebase_storage {
    type: number
    sql: ${TABLE}.Networking_Traffic_Egress_GAE_Firebase_Storage ;;
  }

  dimension: others {
    type: number
    sql: ${TABLE}.OTHERS ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: standard_class_a_operations {
    type: number
    sql: ${TABLE}.STANDARD_CLASS_A_OPERATIONS ;;
  }

  dimension: standard_class_a_operations_type {
    type: string
    sql: ${TABLE}.STANDARD_CLASS_A_OPERATIONS_TYPE ;;
  }

  dimension: standard_class_b_operations {
    type: number
    sql: ${TABLE}.STANDARD_CLASS_B_OPERATIONS ;;
  }

  dimension: standard_class_b_operations_type {
    type: string
    sql: ${TABLE}.STANDARD_CLASS_B_OPERATIONS_TYPE ;;
  }

  dimension: storage {
    type: number
    sql: ${TABLE}.STORAGE ;;
  }

  dimension: storage_type {
    type: string
    sql: ${TABLE}.STORAGE_TYPE ;;
  }

  dimension: subtotal {
    type: number
    sql: ${TABLE}.SUBTOTAL ;;
  }

  dimension_group: usage {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.usage_date ;;
  }

  dimension: usage_gb {
    type: number
    sql: ${TABLE}.USAGE_GB ;;
    value_format_name: decimal_2
  }

  measure: sum_STORAGE {
    type: sum
    sql: ${storage} ;;
    value_format_name: decimal_2
  }

  measure: sum_USAGE_GB {
    type: sum
    sql: ${usage_gb} ;;
    value_format_name: decimal_2
  }

  measure: sum_STORAGE_CLASS_A_OPERATIONS {
    type: sum
    sql: ${standard_class_a_operations} ;;
    value_format_name: decimal_2
  }

  measure: sum_STORAGE_CLASS_B_OPERATIONS {
    type: sum
    sql: ${standard_class_b_operations} ;;
    value_format_name: decimal_2
  }

  measure: sum_NETWORK_PRICE {
    type: sum
    sql: ${network_price} ;;
    value_format_name: decimal_2
  }

  measure: sum_OTHERS {
    type: sum
    sql: ${others} ;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTALS {
    type: sum
    sql: ${subtotal} ;;
    value_format_name: decimal_2
  }

  measure: sum_download_apac {
    type: sum
    sql: ${download_apac} ;;
    value_format_name: decimal_2
  }

  measure: sum_download_australia{
    type: sum
    sql: ${download_australia} ;;
    value_format_name: decimal_2
  }

  measure: sum_download_china {
    type: sum
    sql: ${download_china} ;;
    value_format_name: decimal_2
  }

  measure: sum_worldwide_destinations_excluding_asia_australia {
    type: sum
    sql: ${download_worldwide_destinations_excluding_asia_australia} ;;
    value_format_name: decimal_2
  }

  measure: sum_apac_based_storage_egress_via_peered_interconnect_network {
    type: sum
    sql: ${apac_based_storage_egress_via_peered_interconnect_network} ;;
    value_format_name: decimal_2
  }

  measure: sum_eu_based_storage_egress_via_peered_interconnect_network {
    type: sum
    sql: ${eu_based_storage_egress_via_peered_interconnect_network} ;;
    value_format_name: decimal_2
  }

  measure: sum_na_based_storage_egress_via_peered_interconnect_network {
    type: sum
    sql: ${na_based_storage_egress_via_peered_interconnect_network} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_apac_and_sa {
    type: sum
    sql: ${gcp_storage_egress_between_apac_and_sa} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_au_and_apac {
    type: sum
    sql: ${gcp_storage_egress_between_au_and_apac} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_au_and_eu {
    type: sum
    sql: ${gcp_storage_egress_between_au_and_eu} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_au_and_na {
    type: sum
    sql: ${gcp_storage_egress_between_au_and_na} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_au_and_sa {
    type: sum
    sql: ${gcp_storage_egress_between_au_and_sa} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_eu_and_apac {
    type: sum
    sql: ${gcp_storage_egress_between_eu_and_apac} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_eu_and_sa {
    type: sum
    sql: ${gcp_storage_egress_between_eu_and_sa} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_na_and_apac {
    type: sum
    sql: ${gcp_storage_egress_between_na_and_apac} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_na_and_eu {
    type: sum
    sql: ${gcp_storage_egress_between_na_and_eu} ;;
    value_format_name: decimal_2
  }

  measure: sum_gcp_storage_egress_between_na_and_sa {
    type: sum
    sql: ${gcp_storage_egress_between_na_and_sa} ;;
    value_format_name: decimal_2
  }

  measure: sum_inter_region_gcp_storage_egress_within_apac {
    type: sum
    sql: ${inter_region_gcp_storage_egress_within_apac} ;;
    value_format_name: decimal_2
  }

  measure: sum_inter_region_gcp_storage_egress_within_au {
    type: sum
    sql: ${inter_region_gcp_storage_egress_within_au} ;;
    value_format_name: decimal_2
  }

  measure: sum_inter_region_gcp_storage_egress_within_eu {
    type: sum
    sql: ${inter_region_gcp_storage_egress_within_eu} ;;
    value_format_name: decimal_2
  }

  measure: sum_inter_region_gcp_storage_egress_within_sa {
    type: sum
    sql: ${inter_region_gcp_storage_egress_within_sa} ;;
    value_format_name: decimal_2
  }

  measure: sum_networking_traffic_egress_gae_firebase_storage {
    type: sum
    sql: ${networking_traffic_egress_gae_firebase_storage} ;;
    value_format_name: decimal_2
  }

  measure: sum_network_price {
    type: sum
    sql: ${network_price} ;;
    value_format_name: decimal_2
  }

  measure: count {
    type: count
    drill_fields: [project_name, bucket_name, billing_name]
  }
}
