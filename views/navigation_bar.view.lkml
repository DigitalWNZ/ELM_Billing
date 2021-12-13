include: "navigation_bar.view.lkml"
view: navigation_bar {

  measure: dash_nav {
    view_label: "Navigation"
    group_label: "Dashboard Navigation"
    label: "Navigation Bar"
    type: string
    sql: "";;
    html:
      <div style="background-color: #FEFEFE; border: solid 1px #4285F4; border-radius: 5px; padding: 5px 10px; height: 60px; width:100%">
        <nav style="font-size: 18px; color: #4285F4">
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards-legacy/67">GCE Details</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards-legacy/68">Cannot label Details in GCE</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards-legacy/69">GCS Details</a>
        </nav>
      </div>
;;
  }
}
