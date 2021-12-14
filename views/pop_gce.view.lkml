include: "compute_engine_details_v2.view.lkml"

view: pop_gce {
  extends: [compute_engine_details_v2]

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

  parameter: aggregation_selector_0 {
    type: unquoted
    allowed_value: {label:"Project ID" value:"ProjectID"}
    allowed_value: {label:"Billing Name" value:"BillingName"}
    allowed_value: {label:"Invoice Month" value:"InvoiceMonth"}
    allowed_value: {label:"Instance Name" value:"InstanceName"}
    allowed_value: {label: "PSM" value:"PSM"}
    allowed_value: {label:"Inner IP" value:"InnerIP"}
  }

  # dimension: filter_text_0  {
  #   label_from_parameter: aggregation_selector_0
  #   type: string
  #   sql:
  #     {% if aggregation_selector_0._parameter_value == "ProjectID" %} "Usage+Date=30+days&Psm=&Invoice+Month=&Instance+Name=&Billing+Name=&Project+ID={{ value | encode_uri }}&Inner+IP="
  #     {% elsif aggregation_selector_0._parameter_value == "BillingName" %} "Usage+Date=30+days&Psm=&Invoice+Month=&Instance+Name=&Billing+Name={{ value | encode_uri }}&Project+ID=&Inner+IP="
  #     {% elsif aggregation_selector_0._parameter_value == "InvoiceMonth" %} "Usage+Date=30+days&Psm=&Invoice+Month={{ value | encode_uri }}&Instance+Name=&Billing+Name=&Project+ID=&Inner+IP="
  #     {% elsif aggregation_selector_0._parameter_value == "InstanceName" %} "Usage+Date=30+days&Psm=&Invoice+Month=&Instance+Name={{ value | encode_uri }}&Billing+Name=&Project+ID=&Inner+IP="
  #     {% elsif aggregation_selector_0._parameter_value == "PSM" %} "Usage+Date=30+days&Psm={{ value | encode_uri }}&Invoice+Month=&Instance+Name=&Billing+Name=&Project+ID=&Inner+IP="
  #     {% elsif aggregation_selector_0._parameter_value == "InnerIP" %} "Usage+Date=30+days&Psm=&Invoice+Month=&Instance+Name=&Billing+Name=&Project+ID=&Inner+IP={{ value | encode_uri }}"
  #     {% else %}NULL{% endif %} ;;
  # }

  dimension: aggregation_dim_0  {
    label_from_parameter: aggregation_selector_0
    type: string
    sql:
      {% if aggregation_selector_0._parameter_value == "ProjectID" %} ${project_id}
      {% elsif aggregation_selector_0._parameter_value == "BillingName" %} ${billing_name}
      {% elsif aggregation_selector_0._parameter_value == "InvoiceMonth" %} ${invoice_month}
      {% elsif aggregation_selector_0._parameter_value == "InstanceName" %} ${instance_name}
      {% elsif aggregation_selector_0._parameter_value == "PSM" %} ${psm}
      {% elsif aggregation_selector_0._parameter_value == "InnerIP" %} ${inner_ip}
      {% else %}NULL{% endif %} ;;
    link: {
      label: "PSM: {{value}} Detail Dashboard (Only valid for PSM)"
      url: "/dashboards/71?Usage+Date={{ _filters['pop_gce.current_date_range'] | url_encode }}&Psm={{ value | encode_uri }}&Invoice+Month=&Instance+Name=&Billing+Name=&Project+ID=&Inner+IP="
      # url: "/dashboards/71?{{filter_text_0._value | encode_uri}}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }


  parameter: measure_selector_0 {
    type: unquoted
    allowed_value: {label:"CPU" value:"CPU"}
    allowed_value: {label:"GPU" value:"GPU"}
    allowed_value: {label:"RAM" value:"RAM"}
    allowed_value: {label:"PDHDD" value:"PDHDD"}
    allowed_value: {label:"PDSSD" value:"PDSSD"}
    allowed_value: {label: "LocalSSD" value:"LocalSSD"}
    allowed_value: {label:"NETWORK" value:"NETWORK"}
    allowed_value: {label:"OTHERS" value:"OTHERS"}
    allowed_value: {label:"SUBTOTALS" value:"SUBTOTALS"}
  }

  measure: measure_dim_0  {
    label_from_parameter: measure_selector_0
    type: number
    sql:
      {% if measure_selector_0._parameter_value == "CPU" %} ${sum_CPU}
      {% elsif measure_selector_0._parameter_value == "GPU" %} ${sum_GPU}
      {% elsif measure_selector_0._parameter_value == "RAM" %} ${sum_RAM}
      {% elsif measure_selector_0._parameter_value == "PDHDD" %} ${sum_PDHDD}
      {% elsif measure_selector_0._parameter_value == "PDSSD" %} ${sum_PDSSD}
      {% elsif measure_selector_0._parameter_value == "LocalSSD" %} ${sumb_LOCAL_SSD}
      {% elsif measure_selector_0._parameter_value == "NETWORK" %} ${sum_NETWORK}
      {% elsif measure_selector_0._parameter_value == "OTHERS" %} ${sum_OTHERS}
      {% elsif measure_selector_0._parameter_value == "SUBTOTALS" %} ${sum_SUBTOTALS}
      {% else %}NULL{% endif %} ;;
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,measure_dim_0]
  }

  measure: measure_dim_0_this  {
    label:"{% if measure_selector_0._parameter_value == 'CPU' %} CPU in current period
      {% elsif measure_selector_0._parameter_value == 'GPU' %} GPU in current period
      {% elsif measure_selector_0._parameter_value == 'RAM' %} RAM in current period
      {% elsif measure_selector_0._parameter_value == 'PDHDD' %} PDHDD in current period
      {% elsif measure_selector_0._parameter_value == 'PDSSD' %} PDSSD in current period
      {% elsif measure_selector_0._parameter_value == 'LocalSSD' %} LocalSSD in current period
      {% elsif measure_selector_0._parameter_value == 'NETWORK' %} NETWORK in current period
      {% elsif measure_selector_0._parameter_value == 'OTHERS' %} OTHERS in current period
      {% elsif measure_selector_0._parameter_value == 'SUBTOTALS' %} SUBTOTALS in current period
      {% else %}NULL{% endif %}"
    type: number
    sql:
      {% if measure_selector_0._parameter_value == "CPU" %} ${sum_CPU_this}
      {% elsif measure_selector_0._parameter_value == "GPU" %} ${sum_GPU_this}
      {% elsif measure_selector_0._parameter_value == "RAM" %} ${sum_RAM_this}
      {% elsif measure_selector_0._parameter_value == "PDHDD" %} ${sum_PDHDD_this}
      {% elsif measure_selector_0._parameter_value == "PDSSD" %} ${sum_PDSSD_this}
      {% elsif measure_selector_0._parameter_value == "LocalSSD" %} ${sumb_LOCAL_SSD_this}
      {% elsif measure_selector_0._parameter_value == "NETWORK" %} ${sum_NETWORK_this}
      {% elsif measure_selector_0._parameter_value == "OTHERS" %} ${sum_OTHERS_this}
      {% elsif measure_selector_0._parameter_value == "SUBTOTALS" %} ${sum_SUBTOTALS_this}
      {% else %}NULL{% endif %} ;;
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,measure_dim_0_this]
  }

  measure: measure_dim_0_last  {
    label:"{% if measure_selector_0._parameter_value == 'CPU' %} CPU in last period
    {% elsif measure_selector_0._parameter_value == 'GPU' %} GPU in last period
    {% elsif measure_selector_0._parameter_value == 'RAM' %} RAM in last period
    {% elsif measure_selector_0._parameter_value == 'PDHDD' %} PDHDD in last period
    {% elsif measure_selector_0._parameter_value == 'PDSSD' %} PDSSD in last period
    {% elsif measure_selector_0._parameter_value == 'LocalSSD' %} LocalSSD in last period
    {% elsif measure_selector_0._parameter_value == 'NETWORK' %} NETWORK in last period
    {% elsif measure_selector_0._parameter_value == 'OTHERS' %} OTHERS in last period
    {% elsif measure_selector_0._parameter_value == 'SUBTOTALS' %} SUBTOTALS in last period
    {% else %}NULL{% endif %}"
    type: number
    sql:
      {% if measure_selector_0._parameter_value == "CPU" %} ${sum_CPU_last}
      {% elsif measure_selector_0._parameter_value == "GPU" %} ${sum_GPU_last}
      {% elsif measure_selector_0._parameter_value == "RAM" %} ${sum_RAM_last}
      {% elsif measure_selector_0._parameter_value == "PDHDD" %} ${sum_PDHDD_last}
      {% elsif measure_selector_0._parameter_value == "PDSSD" %} ${sum_PDSSD_last}
      {% elsif measure_selector_0._parameter_value == "LocalSSD" %} ${sumb_LOCAL_SSD_last}
      {% elsif measure_selector_0._parameter_value == "NETWORK" %} ${sum_NETWORK_last}
      {% elsif measure_selector_0._parameter_value == "OTHERS" %} ${sum_OTHERS_last}
      {% elsif measure_selector_0._parameter_value == "SUBTOTALS" %} ${sum_SUBTOTALS_last}
      {% else %}NULL{% endif %} ;;
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,measure_dim_0_last]
  }

  measure: measure_dim_0_delta  {
    label:"{% if measure_selector_0._parameter_value == 'CPU' %} CPU delta
    {% elsif measure_selector_0._parameter_value == 'GPU' %} GPU delta
    {% elsif measure_selector_0._parameter_value == 'RAM' %} RAM delta
    {% elsif measure_selector_0._parameter_value == 'PDHDD' %} PDHDD delta
    {% elsif measure_selector_0._parameter_value == 'PDSSD' %} PDSSD delta
    {% elsif measure_selector_0._parameter_value == 'LocalSSD' %} LocalSSD delta
    {% elsif measure_selector_0._parameter_value == 'NETWORK' %} NETWORK delta
    {% elsif measure_selector_0._parameter_value == 'OTHERS' %} OTHERS delta
    {% elsif measure_selector_0._parameter_value == 'SUBTOTALS' %} SUBTOTALS delta
    {% else %}NULL{% endif %}"
    type: number
    sql:if(${measure_dim_0_last}>0,(${measure_dim_0_this}-${measure_dim_0_last})/${measure_dim_0_last},null);;
    value_format_name: percent_2
  }




  parameter: time_granulariry_0 {
    type: unquoted
    allowed_value: {label:"Year" value: "Year" }
    allowed_value: {label:"Quarter" value: "Quarter"}
    allowed_value: {label:"Month" value: "Month"}
    allowed_value: {label:"Week" value: "Week"}
    allowed_value: {label:"Day" value: "Day"}
  }

  dimension: time_dim_0  {
    label_from_parameter: time_granulariry_0
    sql:
      {% if time_granulariry_0._parameter_value == "Year" %} ${usage_year}
      {% elsif time_granulariry_0._parameter_value == "Quarter" %} ${usage_quarter}
      {% elsif time_granulariry_0._parameter_value == "Month" %} ${usage_month}
      {% elsif time_granulariry_0._parameter_value == "Week" %} ${usage_week}
      {% elsif time_granulariry_0._parameter_value == "Day" %} ${usage_date}
      {% else %}NULL{% endif %} ;;
  }

  # parameter: aggregation_selector_1 {
  #   type: unquoted
  #   allowed_value: {value:"ProjectID"}
  #   allowed_value: {value:"BillingName"}
  #   allowed_value: {value:"InvoiceMonth"}
  #   allowed_value: {value:"InstanceName"}
  #   allowed_value: {value:"PSM"}
  #   allowed_value: {value:"InnerIP"}
  # }

  # dimension: aggregation_dim_1  {
  #   type: string
  #   sql:
  #     {% if aggregation_selector_1._parameter_value == 'ProjectID' %} ${project_id}
  #     {% elsif aggregation_selector_1._parameter_value == 'BillingName' %} ${billing_name}
  #     {% elsif aggregation_selector_1._parameter_value == 'InvoiceMonth' %} ${invoice_month}
  #     {% elsif aggregation_selector_1._parameter_value == 'InstanceName' %} ${instance_name}
  #     {% elsif aggregation_selector_1._parameter_value == 'PSM' %} ${psm}
  #     {% elsif aggregation_selector_1._parameter_value == 'InnerIP' %} ${inner_ip}
  #     {% else %}NULL{% endif %} ;;
  # }

  # parameter: measure_selector_1 {
  #   type: unquoted
  #   allowed_value: {value:"CPU"}
  #   allowed_value: {value:"GPU"}
  #   allowed_value: {value:"RAM"}
  #   allowed_value: {value:"PDHDD"}
  #   allowed_value: {value:"PDSSD"}
  #   allowed_value: {value:"LocalSSD"}
  #   allowed_value: {value:"NETWORK"}
  #   allowed_value: {value:"OTHERS"}
  #   allowed_value: {value:"SUBTOTALS"}
  # }

  # measure: measure_dim_1  {
  #   type: number
  #   sql:
  #     {% if measure_selector_1._parameter_value == 'CPU' %} ${sum_CPU}
  #     {% elsif measure_selector_1._parameter_value == 'GPU' %} ${sum_GPU}
  #     {% elsif measure_selector_1._parameter_value == 'RAM' %} ${sum_RAM}
  #     {% elsif measure_selector_1._parameter_value == 'PDHDD' %} ${sum_PDHDD}
  #     {% elsif measure_selector_1._parameter_value == 'PDSSD' %} ${sum_PDSSD}
  #     {% elsif measure_selector_1._parameter_value == 'LocalSSD' %} ${sumb_LOCAL_SSD}
  #     {% elsif measure_selector_1._parameter_value == 'NETWORK' %} ${sum_NETWORK}
  #     {% elsif measure_selector_1._parameter_value == 'OTHERS' %} ${sum_OTHERS}
  #     {% elsif measure_selector_1._parameter_value == 'SUBTOTALS' %} ${sum_SUBTOTALS}
  #     {% else %}NULL{% endif %} ;;
  #   value_format_name: decimal_2
  # }


  # parameter: time_granulariry_1 {
  #   type: unquoted
  #   allowed_value: {value: "Year" }
  #   allowed_value: {value: "Quarter"}
  #   allowed_value: {value: "Month"}
  #   allowed_value: {value: "Week"}
  #   allowed_value: {value: "Day"}
  # }

  # dimension: time_dim_1  {
  #   sql:
  #     {% if time_granulariry_1._parameter_value == 'Year' %} ${usage_year}
  #     {% elsif time_granulariry_1._parameter_value == 'Quarter' %} ${usage_quarter}
  #     {% elsif time_granulariry_1._parameter_value == 'Month' %} ${usage_month}
  #     {% elsif time_granulariry_1._parameter_value == 'Week' %} ${usage_week}
  #     {% elsif time_granulariry_1._parameter_value == 'Day' %} ${usage_date}
  #     {% else %}NULL{% endif %} ;;
  # }

  # parameter: aggregation_selector_2 {
  #   type: unquoted
  #   allowed_value: {value:"ProjectID"}
  #   allowed_value: {value:"BillingName"}
  #   allowed_value: {value:"InvoiceMonth"}
  #   allowed_value: {value:"InstanceName"}
  #   allowed_value: {value:"PSM"}
  #   allowed_value: {value:"InnerIP"}
  # }

  # dimension: aggregation_dim_2  {
  #   type: string
  #   sql:
  #     {% if aggregation_selector_2._parameter_value == 'ProjectID' %} ${project_id}
  #     {% elsif aggregation_selector_2._parameter_value == 'BillingName' %} ${billing_name}
  #     {% elsif aggregation_selector_2._parameter_value == 'InvoiceMonth' %} ${invoice_month}
  #     {% elsif aggregation_selector_2._parameter_value == 'InstanceName' %} ${instance_name}
  #     {% elsif aggregation_selector_2._parameter_value == 'PSM' %} ${psm}
  #     {% elsif aggregation_selector_2._parameter_value == 'InnerIP' %} ${inner_ip}
  #     {% else %}NULL{% endif %} ;;
  # }

  # parameter: measure_selector_2 {
  #   type: unquoted
  #   allowed_value: {value:"CPU"}
  #   allowed_value: {value:"GPU"}
  #   allowed_value: {value:"RAM"}
  #   allowed_value: {value:"PDHDD"}
  #   allowed_value: {value:"PDSSD"}
  #   allowed_value: {value:"LocalSSD"}
  #   allowed_value: {value:"NETWORK"}
  #   allowed_value: {value:"OTHERS"}
  #   allowed_value: {value:"SUBTOTALS"}
  # }

  # measure: measure_dim_2  {
  #   type: number
  #   sql:
  #     {% if measure_selector_2._parameter_value == 'CPU' %} ${sum_CPU}
  #     {% elsif measure_selector_2._parameter_value == 'GPU' %} ${sum_GPU}
  #     {% elsif measure_selector_2._parameter_value == 'RAM' %} ${sum_RAM}
  #     {% elsif measure_selector_2._parameter_value == 'PDHDD' %} ${sum_PDHDD}
  #     {% elsif measure_selector_2._parameter_value == 'PDSSD' %} ${sum_PDSSD}
  #     {% elsif measure_selector_2._parameter_value == 'LocalSSD' %} ${sumb_LOCAL_SSD}
  #     {% elsif measure_selector_2._parameter_value == 'NETWORK' %} ${sum_NETWORK}
  #     {% elsif measure_selector_2._parameter_value == 'OTHERS' %} ${sum_OTHERS}
  #     {% elsif measure_selector_2._parameter_value == 'SUBTOTALS' %} ${sum_SUBTOTALS}
  #     {% else %}NULL{% endif %} ;;
  #   value_format_name: decimal_2
  # }


  # parameter: time_granulariry_2 {
  #   type: unquoted
  #   allowed_value: {value: "Year" }
  #   allowed_value: {value: "Quarter"}
  #   allowed_value: {value: "Month"}
  #   allowed_value: {value: "Week"}
  #   allowed_value: {value: "Day"}
  # }

  # dimension: time_dim_2  {
  #   sql:
  #     {% if time_granulariry_2._parameter_value == 'Year' %} ${usage_year}
  #     {% elsif time_granulariry_2._parameter_value == 'Quarter' %} ${usage_quarter}
  #     {% elsif time_granulariry_2._parameter_value == 'Month' %} ${usage_month}
  #     {% elsif time_granulariry_2._parameter_value == 'Week' %} ${usage_week}
  #     {% elsif time_granulariry_2._parameter_value == 'Day' %} ${usage_date}
  #     {% else %}NULL{% endif %} ;;
  # }

  # Current period

  measure: sum_CPU_this {
    type: sum
    sql: ${cpu} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_CPU_this]
  }

  measure: sum_GPU_this {
    type: sum
    sql: ${gpu} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_GPU_this]
  }

  measure: sum_RAM_this {
    type: sum
    sql: ${ram} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_RAM_this]
  }

  measure: sum_PDHDD_this {
    type: sum
    sql: ${pd_hdd} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_PDHDD_this]
  }

  measure: sumb_LOCAL_SSD_this {
    type:sum
    sql: ${local_ssd} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sumb_LOCAL_SSD_this]
  }

  measure: sum_PDSSD_this {
    type: sum
    sql: pd_ssd ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_PDSSD_this]
  }

  measure: sum_NETWORK_this {
    type: sum
    sql: ${network} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_NETWORK_this]
  }

  measure: sum_OTHERS_this {
    type: sum
    sql: ${others} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_OTHERS_this]
  }

  measure: sum_SUBTOTALS_this {
    type: sum
    sql: ${subtotal} ;;
    filters: [period_filtered_measures: "this"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_SUBTOTALS_this]
  }


  # Last period

  measure: sum_CPU_last {
    type: sum
    sql: ${cpu} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_CPU_last]
  }

  measure: sum_GPU_last {
    type: sum
    sql: ${gpu} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_GPU_last]
  }

  measure: sum_RAM_last {
    type: sum
    sql: ${ram} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_RAM_last]
  }

  measure: sum_PDHDD_last {
    type: sum
    sql: ${pd_hdd} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_PDHDD_last]
  }

  measure: sumb_LOCAL_SSD_last {
    type:sum
    sql: ${local_ssd} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sumb_LOCAL_SSD_last]
  }

  measure: sum_PDSSD_last {
    type: sum
    sql: pd_ssd ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_PDSSD_last]
  }

  measure: sum_NETWORK_last {
    type: sum
    sql: ${network} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_NETWORK_last]
  }

  measure: sum_OTHERS_last {
    type: sum
    sql: ${others} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_OTHERS_last]
  }

  measure: sum_SUBTOTALS_last {
    type: sum
    sql: ${subtotal} ;;
    filters: [period_filtered_measures: "last"]
    value_format_name: decimal_2
    drill_fields: [aggregation_dim_0,sum_SUBTOTALS_last]
  }

}

# ---------- EXPLORE ---------- #

explore: pop_gce {
}
