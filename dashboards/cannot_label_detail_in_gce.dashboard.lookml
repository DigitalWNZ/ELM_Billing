- dashboard: cannot_label_detail_in_gce
  title: Cannot Label Detail in GCE
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: Cannot Label Total
    name: Cannot Label Total
    model: elm_billing
    explore: compute_others_details
    type: single_value
    fields: [compute_others_details.sum_SUBTOTAL_all]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: compute_others_details.invoice_month
      Usage Date: compute_others_details.usage_date
    row: 2
    col: 0
    width: 8
    height: 3
  - title: Cloud Interconnect
    name: Cloud Interconnect
    model: elm_billing
    explore: compute_others_details
    type: single_value
    fields: [compute_others_details.sum_SUBTOTAL_interconnect]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: compute_others_details.invoice_month
      Usage Date: compute_others_details.usage_date
    row: 2
    col: 8
    width: 8
    height: 3
  - title: NAT
    name: NAT
    model: elm_billing
    explore: compute_others_details
    type: single_value
    fields: [compute_others_details.sum_SUBTOTAL_NAT]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: compute_others_details.invoice_month
      Usage Date: compute_others_details.usage_date
    row: 2
    col: 16
    width: 8
    height: 3
  - title: Static IP
    name: Static IP
    model: elm_billing
    explore: compute_others_details
    type: single_value
    fields: [compute_others_details.sum_SUBTOTAL_StaticIP]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: compute_others_details.invoice_month
      Usage Date: compute_others_details.usage_date
    row: 5
    col: 0
    width: 8
    height: 3
  - title: Load Balancing
    name: Load Balancing
    model: elm_billing
    explore: compute_others_details
    type: single_value
    fields: [compute_others_details.sum_SUBTOTAL_LB]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: compute_others_details.invoice_month
      Usage Date: compute_others_details.usage_date
    row: 5
    col: 8
    width: 8
    height: 3
  - title: Cloud Armor
    name: Cloud Armor
    model: elm_billing
    explore: compute_others_details
    type: single_value
    fields: [compute_others_details.sum_SUBTOTAL_CloudArmor]
    limit: 500
    query_timezone: Asia/Shanghai
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Invoice Month: compute_others_details.invoice_month
      Usage Date: compute_others_details.usage_date
    row: 5
    col: 16
    width: 8
    height: 3
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
