include: "compute_others_details.view.lkml"

view: pop_other {
  extends: [compute_others_details]

  filter: current_date_range {
    type: date
    view_label: "_PoP"
    label: "1. Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Event Date covers this period, or is removed."
    convert_tz: no
  }

  dimension: days_in_period {
    # hidden:  yes
    view_label: "_PoP"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: DATE_DIFF(DATE({% date_end current_date_range %}),DATE({% date_start current_date_range %}), DAY) ;;
  }

  dimension: period_2_start {
    # hidden:  yes
    view_label: "_PoP"
    description: "Calculates the start of the previous period"
    type: date
    sql:
        DATE_SUB(DATE({% date_start current_date_range %}), INTERVAL ${days_in_period} DAY);;
    convert_tz: no
  }

  dimension: period_2_end {
    # hidden:  yes
    view_label: "_PoP"
    description: "Calculates the end of the previous period"
    type: date
    sql:
        DATE_SUB(DATE({% date_start current_date_range %}), INTERVAL 1 DAY);;
    convert_tz: no
  }

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
    {% if current_date_range._is_filtered %}
        CASE
        WHEN {% condition current_date_range %} timestamp(${usage_raw}) {% endcondition %}
        THEN DATE_DIFF( ${usage_date},DATE({% date_start current_date_range %}), DAY) + 1
        WHEN ${usage_raw} between ${period_2_start} and ${period_2_end}
        THEN DATE_DIFF(${usage_date},${period_2_start}, DAY) + 1
        END
    {% else %} NULL
    {% endif %}
    ;;
  }

  dimension: order_for_period {
    hidden: yes
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} timestamp(${usage_raw}) {% endcondition %}
            THEN 1
            WHEN ${usage_date} between ${period_2_start} and ${period_2_end}
            THEN 2
            END
        {% else %}
            NULL
        {% endif %}
        ;;
  }
  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    # sql: DATE_ADD( ${day_in_period} - 1, DATE({% date_start current_date_range %}), DAY) ;;
    sql: DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL (${day_in_period} - 1) DAY)  ;;
    view_label: "_PoP"
    timeframes: [
      date,
      hour_of_day,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week_of_year,
      month,
      month_name,
      month_num,
      year]
    convert_tz: no
  }


  dimension: period {
    view_label: "_PoP"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    order_by_field: order_for_period
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} timestamp(${usage_raw}) {% endcondition %}
            THEN 'This Period'
            WHEN ${usage_date} between ${period_2_start} and ${period_2_end}
            THEN 'Last Period'
            END
        {% else %}
            NULL
        {% endif %}
        ;;
  }

  dimension: in_range {
    description: "We just use this for the aggregate measure"
    type: string
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} timestamp(${usage_raw}) {% endcondition %} THEN 'yes'
            WHEN ${usage_date} between ${period_2_start} and ${period_2_end} THEN 'yes' END
        {% else %} NULL {% endif %} ;;
  }

  dimension: period_filtered_measures {
    hidden: yes
    description: "We just use this for the filtered measures"
    type: string
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} timestamp(${usage_raw}) {% endcondition %} THEN 'this'
            WHEN ${usage_date} between ${period_2_start} and ${period_2_end} THEN 'last' END
        {% else %} NULL {% endif %} ;;
  }


  # Current period

  measure: sum_SUBTOTAL_all_curr {
    type:sum
    sql: ${subtotal} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_interconnect_curr {
    type:sum
    sql:
    case
      when ${description} like '%Cloud Interconnect%' and ${period_filtered_measures} = 'this' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_NAT_curr {
    type:sum
    sql:
    case
      when ${description} like '%NAT%' and ${period_filtered_measures} = 'this' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_StaticIP_curr {
    type:sum
    sql:
    case
      when ${description} like '%Static Ip Charge%' and ${period_filtered_measures} = 'this' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_LB_curr {
    type:sum
    sql:
    case
      when ${description} like '%Load Balanc%' and ${period_filtered_measures} = 'this' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_CloudArmor_curr {
    type:sum
    sql:
    case
      when ${description} like '%Cloud Armor%' and ${period_filtered_measures} = 'this' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  # Last period

  measure: sum_SUBTOTAL_all_last {
    type:sum
    sql: ${subtotal} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_interconnect_last {
    type:sum
    sql:
    case
      when ${description} like '%Cloud Interconnect%' and ${period_filtered_measures} = 'last' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_NAT_last {
    type:sum
    sql:
    case
      when ${description} like '%NAT%' and ${period_filtered_measures} = 'last' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_StaticIP_last {
    type:sum
    sql:
    case
      when ${description} like '%Static Ip Charge%' and ${period_filtered_measures} = 'last' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_LB_last {
    type:sum
    sql:
    case
      when ${description} like '%Load Balanc%' and ${period_filtered_measures} = 'last' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

  measure: sum_SUBTOTAL_CloudArmor_last {
    type:sum
    sql:
    case
      when ${description} like '%Cloud Armor%' and ${period_filtered_measures} = 'last' then ${subtotal}
      else null
    end;;
    value_format_name: decimal_2
  }

}

# ---------- EXPLORE ---------- #

explore: pop_other {
}
