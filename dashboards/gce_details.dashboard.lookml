- dashboard: gce_details
  title: GCE Details
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: Compute_Engine
    name: Compute_Engine
    model: elm_billing
    explore: compute_engine_details_v2
    type: single_value
    fields: [compute_engine_details_v2.sum_SUBTOTALS]
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
    series_types: {}
    defaults_version: 1
    listen:
      Usage Date: compute_engine_details_v2.usage_date
      Psm: compute_engine_details_v2.psm
      Instance Name: compute_engine_details_v2.instance_name
      Invoice Month: compute_engine_details_v2.invoice_month
    row: 4
    col: 0
    width: 24
    height: 2
  - title: vm_detail
    name: vm_detail
    model: elm_billing
    explore: compute_engine_details_v2
    type: looker_grid
    fields: [compute_engine_details_v2.instance_name, compute_engine_details_v2.project_id,
      compute_engine_details_v2.sum_CPU, compute_engine_details_v2.sum_GPU, compute_engine_details_v2.sum_RAM,
      compute_engine_details_v2.sum_PDHDD, compute_engine_details_v2.sum_PDSSD, compute_engine_details_v2.sumb_LOCAL_SSD,
      compute_engine_details_v2.sum_NETWORK, compute_engine_details_v2.sum_OTHERS,
      compute_engine_details_v2.sum_SUBTOTALS]
    sorts: [compute_engine_details_v2.sum_SUBTOTALS desc]
    limit: 500
    column_limit: 50
    total: true
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
    defaults_version: 1
    title_hidden: true
    listen:
      Usage Date: compute_engine_details_v2.usage_date
      Psm: compute_engine_details_v2.psm
      Instance Name: compute_engine_details_v2.instance_name
      Invoice Month: compute_engine_details_v2.invoice_month
    row: 8
    col: 0
    width: 24
    height: 9
  - title: vm_billing
    name: vm_billing
    model: elm_billing
    explore: compute_engine_details_v2
    type: looker_grid
    fields: [compute_engine_details_v2.billing_name, compute_engine_details_v2.project_id,
      compute_engine_details_v2.invoice_month, compute_engine_details_v2.instance_name,
      compute_engine_details_v2.psm, compute_engine_details_v2.inner_ip, compute_engine_details_v2.sum_SUBTOTALS]
    sorts: [compute_engine_details_v2.sum_SUBTOTALS desc]
    limit: 500
    column_limit: 50
    total: true
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
    defaults_version: 1
    title_hidden: true
    listen:
      Usage Date: compute_engine_details_v2.usage_date
      Psm: compute_engine_details_v2.psm
      Instance Name: compute_engine_details_v2.instance_name
      Invoice Month: compute_engine_details_v2.invoice_month
    row: 19
    col: 0
    width: 24
    height: 13
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
  - name: "<span class='fa fa-desktop'> Compute Engine </span>"
    type: text
    title_text: "<span class='fa fa-desktop'> Compute Engine </span>"
    subtitle_text: ''
    body_text: ''
    row: 2
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-asterisk'> Detail by Instance </span>"
    type: text
    title_text: "<span class='fa fa-asterisk'> Detail by Instance </span>"
    subtitle_text: "<p> Detail Information by Individual Instance</p>"
    body_text: ''
    row: 6
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-usd'> Billing by Instance</span>"
    type: text
    title_text: "<span class='fa fa-usd'> Billing by Instance</span>"
    subtitle_text: "<p>Billing information by individual Instance</p>"
    body_text: ''
    row: 17
    col: 0
    width: 24
    height: 2
  filters:
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
    explore: compute_engine_details_v2
    listens_to_filters: []
    field: compute_engine_details_v2.usage_date
  - name: Psm
    title: Psm
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: elm_billing
    explore: compute_engine_details_v2
    listens_to_filters: []
    field: compute_engine_details_v2.psm
  - name: Instance Name
    title: Instance Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: elm_billing
    explore: compute_engine_details_v2
    listens_to_filters: []
    field: compute_engine_details_v2.instance_name
  - name: Invoice Month
    title: Invoice Month
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: inline
      options: []
    model: elm_billing
    explore: compute_engine_details_v2
    listens_to_filters: []
    field: compute_engine_details_v2.invoice_month
