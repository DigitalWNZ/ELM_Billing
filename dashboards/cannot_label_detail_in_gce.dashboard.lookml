- dashboard: cannot_label_detail_in_gce
  title: Cannot Label Detail in GCE
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: subtotal_by_desc
    name: subtotal_by_desc
    model: elm_billing
    explore: compute_others_details
    type: looker_grid
    fields: [compute_others_details.description, compute_others_details.sum_SUBTOTAL_all]
    sorts: [compute_others_details.sum_SUBTOTAL_all desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Invoice Month: compute_others_details.invoice_month
      Usage Date: compute_others_details.usage_date
    row: 10
    col: 0
    width: 24
    height: 10
  - title: Navigation
    name: Navigation
    model: elm_billing
    explore: compute_engine_details_v2
    type: single_value
    fields: [compute_engine_details_v2.dash_nav]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-bookmark'> Subtotal by Description </span>"
    type: text
    title_text: "<span class='fa fa-bookmark'> Subtotal by Description </span>"
    subtitle_text: ''
    body_text: ''
    row: 8
    col: 0
    width: 24
    height: 2
  - title: cannot_label_comp_v1
    name: cannot_label_comp_v1
    model: elm_billing
    explore: pop_other
    type: single_value
    fields: [pop_other.sum_SUBTOTAL_all_curr, pop_other.sum_SUBTOTAL_all_last, pop_other.in_range]
    filters: {}
    sorts: [pop_other.sum_SUBTOTAL_all_curr desc]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Cannot Label Total
    comparison_label: from Previous Period
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Invoice Month: pop_other.invoice_month
      Usage Date: pop_other.current_date_range
    row: 2
    col: 0
    width: 8
    height: 3
  - title: cloudinterconnect_comp_v1
    name: cloudinterconnect_comp_v1
    model: elm_billing
    explore: pop_other
    type: single_value
    fields: [pop_other.sum_SUBTOTAL_interconnect_curr, pop_other.sum_SUBTOTAL_interconnect_last,
      pop_other.in_range]
    filters: {}
    sorts: [pop_other.sum_SUBTOTAL_interconnect_curr desc]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Cloud Interconnect
    comparison_label: from Previous Period
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: pop_other.invoice_month
      Usage Date: pop_other.current_date_range
    row: 2
    col: 8
    width: 8
    height: 3
  - title: NAT_comp_v1
    name: NAT_comp_v1
    model: elm_billing
    explore: pop_other
    type: single_value
    fields: [pop_other.in_range, pop_other.sum_SUBTOTAL_NAT_curr, pop_other.sum_SUBTOTAL_NAT_last]
    filters: {}
    sorts: [pop_other.sum_SUBTOTAL_NAT_curr desc]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: NAT
    comparison_label: from Previous Period
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: pop_other.invoice_month
      Usage Date: pop_other.current_date_range
    row: 2
    col: 16
    width: 8
    height: 3
  - title: staticip_comp_v1
    name: staticip_comp_v1
    model: elm_billing
    explore: pop_other
    type: single_value
    fields: [pop_other.in_range, pop_other.sum_SUBTOTAL_StaticIP_curr, pop_other.sum_SUBTOTAL_StaticIP_last]
    filters: {}
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Static IP
    comparison_label: from Previous Period
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: pop_other.invoice_month
      Usage Date: pop_other.current_date_range
    row: 5
    col: 0
    width: 8
    height: 3
  - title: LB_comp_v1
    name: LB_comp_v1
    model: elm_billing
    explore: pop_other
    type: single_value
    fields: [pop_other.in_range, pop_other.sum_SUBTOTAL_LB_curr, pop_other.sum_SUBTOTAL_LB_last]
    filters: {}
    sorts: [pop_other.sum_SUBTOTAL_LB_curr desc]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: LB
    comparison_label: from Previous Period
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: pop_other.invoice_month
      Usage Date: pop_other.current_date_range
    row: 5
    col: 8
    width: 8
    height: 3
  - title: cloudarmor_comp_v1
    name: cloudarmor_comp_v1
    model: elm_billing
    explore: pop_other
    type: single_value
    fields: [pop_other.in_range, pop_other.sum_SUBTOTAL_CloudArmor_curr, pop_other.sum_SUBTOTAL_CloudArmor_last]
    filters: {}
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Cloud Armor
    comparison_label: from Previous Period
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: pop_other.invoice_month
      Usage Date: pop_other.current_date_range
    row: 5
    col: 16
    width: 8
    height: 3
  filters:
  - name: Invoice Month
    title: Invoice Month
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: elm_billing
    explore: compute_others_details
    listens_to_filters: []
    field: compute_others_details.invoice_month
  - name: Usage Date
    title: Usage Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: elm_billing
    explore: compute_others_details
    listens_to_filters: []
    field: compute_others_details.usage_date
