view: compute_others_details {
  sql_table_name: `report.compute_others_details`
    ;;

  dimension: billing_name {
    type: string
    sql: ${TABLE}.billing_name ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: invoice_month {
    type: string
    sql: ${TABLE}.invoice_month ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: subtotal {
    type: number
    sql: ${TABLE}.SUBTOTAL ;;
  }

  measure: sum_SUBTOTAL_all {
    type:sum
    sql: ${subtotal} ;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_interconnect {
    type:sum
    sql:
    case
      when ${description} like '%Cloud Interconnect%' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_NAT {
    type:sum
    sql:
    case
      when ${description} like '%NAT%' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_StaticIP {
    type:sum
    sql:
    case
      when ${description} like '%Static Ip Charge%' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_LB {
    type:sum
    sql:
    case
      when ${description} like '%Load Balanc%' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_CloudArmor {
    type:sum
    sql:
    case
      when ${description} like '%Cloud Armor%' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
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
    drill_fields: [billing_name, project_name]
  }
}
