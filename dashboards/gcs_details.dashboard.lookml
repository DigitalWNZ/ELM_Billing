- dashboard: gcs_details
  title: GCS Details
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: by_bucket
    name: by_bucket
    model: elm_billing
    explore: storage_details_v2
    type: looker_grid
    fields: [storage_details_v2.bucket_name, storage_details_v2.sum_STORAGE, storage_details_v2.sum_USAGE_GB,
      storage_details_v2.sum_STORAGE_CLASS_A_OPERATIONS, storage_details_v2.sum_STORAGE_CLASS_B_OPERATIONS,
      storage_details_v2.sum_NETWORK_PRICE, storage_details_v2.sum_OTHERS, storage_details_v2.sum_SUBTOTALS]
    sorts: [storage_details_v2.sum_STORAGE desc]
    limit: 500
    query_timezone: Asia/Shanghai
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
      Usage Date: storage_details_v2.usage_date
      Invoice Month: storage_details_v2.invoice_month
      Bucket Name: storage_details_v2.bucket_name
    row: 8
    col: 0
    width: 24
    height: 9
  - title: by_billing
    name: by_billing
    model: elm_billing
    explore: storage_details_v2
    type: looker_grid
    fields: [storage_details_v2.billing_name, storage_details_v2.bucket_name, storage_details_v2.invoice_month,
      storage_details_v2.project_name, storage_details_v2.region, storage_details_v2.storage_type,
      storage_details_v2.standard_class_a_operations_type, storage_details_v2.standard_class_b_operations_type,
      storage_details_v2.sum_SUBTOTALS]
    sorts: [storage_details_v2.sum_SUBTOTALS desc]
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
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    title_hidden: true
    listen:
      Usage Date: storage_details_v2.usage_date
      Invoice Month: storage_details_v2.invoice_month
      Bucket Name: storage_details_v2.bucket_name
    row: 19
    col: 0
    width: 24
    height: 9
  - title: download_by_bucket
    name: download_by_bucket
    model: elm_billing
    explore: storage_details_v2
    type: looker_grid
    fields: [storage_details_v2.bucket_name, storage_details_v2.sum_download_apac,
      storage_details_v2.sum_download_australia, storage_details_v2.sum_download_china,
      storage_details_v2.sum_worldwide_destinations_excluding_asia_australia, storage_details_v2.sum_apac_based_storage_egress_via_peered_interconnect_network,
      storage_details_v2.sum_eu_based_storage_egress_via_peered_interconnect_network,
      storage_details_v2.sum_na_based_storage_egress_via_peered_interconnect_network,
      storage_details_v2.sum_gcp_storage_egress_between_apac_and_sa, storage_details_v2.sum_gcp_storage_egress_between_au_and_apac,
      storage_details_v2.sum_gcp_storage_egress_between_au_and_eu, storage_details_v2.sum_gcp_storage_egress_between_au_and_na,
      storage_details_v2.sum_gcp_storage_egress_between_au_and_sa, storage_details_v2.sum_gcp_storage_egress_between_eu_and_apac,
      storage_details_v2.sum_gcp_storage_egress_between_eu_and_sa, storage_details_v2.sum_gcp_storage_egress_between_na_and_apac,
      storage_details_v2.sum_gcp_storage_egress_between_na_and_eu, storage_details_v2.sum_gcp_storage_egress_between_na_and_sa,
      storage_details_v2.sum_inter_region_gcp_storage_egress_within_apac, storage_details_v2.sum_inter_region_gcp_storage_egress_within_au,
      storage_details_v2.sum_inter_region_gcp_storage_egress_within_eu, storage_details_v2.sum_inter_region_gcp_storage_egress_within_sa,
      storage_details_v2.sum_networking_traffic_egress_gae_firebase_storage, storage_details_v2.sum_NETWORK_PRICE]
    sorts: [storage_details_v2.sum_download_apac desc]
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
      Usage Date: storage_details_v2.usage_date
      Invoice Month: storage_details_v2.invoice_month
      Bucket Name: storage_details_v2.bucket_name
    row: 30
    col: 0
    width: 24
    height: 9
  - title: total
    name: total
    model: elm_billing
    explore: storage_details_v2
    type: single_value
    fields: [storage_details_v2.sum_SUBTOTALS]
    limit: 500
    column_limit: 50
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
      Usage Date: storage_details_v2.usage_date
      Invoice Month: storage_details_v2.invoice_month
      Bucket Name: storage_details_v2.bucket_name
    row: 4
    col: 0
    width: 24
    height: 2
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
  - name: "<span class='fa fa-usd'> Storage Cost </span>"
    type: text
    title_text: "<span class='fa fa-usd'> Storage Cost </span>"
    subtitle_text: ''
    body_text: ''
    row: 2
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-asterisk'> Detail by Bucket </span>"
    type: text
    title_text: "<span class='fa fa-asterisk'> Detail by Bucket </span>"
    subtitle_text: "<p> Detail Information by Each Individual Bucket</p>"
    body_text: ''
    row: 6
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-money'> Billing by Bucket </span>"
    type: text
    title_text: "<span class='fa fa-money'> Billing by Bucket </span>"
    subtitle_text: "<p> Billing by Each Individual Bucket</p>"
    body_text: ''
    row: 17
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-download'> Download by Bucket</span>"
    type: text
    title_text: "<span class='fa fa-download'> Download by Bucket</span>"
    subtitle_text: "<p> Download Detail by Bucket</p>"
    body_text: ''
    row: 28
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
    explore: storage_details_v2
    listens_to_filters: []
    field: storage_details_v2.usage_date
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
    explore: storage_details_v2
    listens_to_filters: []
    field: storage_details_v2.invoice_month
  - name: Bucket Name
    title: Bucket Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: elm_billing
    explore: storage_details_v2
    listens_to_filters: []
    field: storage_details_v2.bucket_name
