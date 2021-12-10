view: compute_engine_details {
  sql_table_name: `report.compute_engine_details`
    ;;

  dimension: billing_name {
    type: string
    sql: ${TABLE}.billing_name ;;
  }

  dimension: cpu {
    type: number
    sql: ${TABLE}.CPU ;;
  }

  dimension: gpu {
    type: number
    sql: ${TABLE}.GPU ;;
  }

  dimension: inner_ip {
    type: string
    sql: ${TABLE}.inner_ip ;;
  }

  dimension: instance_name {
    type: string
    sql: ${TABLE}.instance_name ;;
  }

  dimension: invoice_month {
    type: string
    sql: ${TABLE}.invoice_month ;;
  }

  dimension: local_ssd {
    type: number
    sql: ${TABLE}.LOCAL_SSD ;;
  }

  dimension: network {
    type: number
    sql: ${TABLE}.NETWORK ;;
  }

  dimension: others {
    type: number
    sql: ${TABLE}.OTHERS ;;
  }

  dimension: pd_hdd {
    type: number
    sql: ${TABLE}.PD_HDD ;;
  }

  dimension: pd_ssd {
    type: number
    sql: ${TABLE}.PD_SSD ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: psm {
    type: string
    sql: ${TABLE}.psm ;;
  }

  dimension: ram {
    type: number
    sql: ${TABLE}.RAM ;;
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

  measure: count {
    type: count
    drill_fields: [instance_name, billing_name]
  }
}
