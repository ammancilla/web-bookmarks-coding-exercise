module ApplicationHelper
  def render_flash_messages
    return if flash.empty?

    flash.inject('') do |html, flash_data|
      flash_type = flash_data[0]
      flash_msg = flash_data[1]

      alert_type =
        case flash_type
        when 'notice'
          'info'
        when 'error'
          'danger'
        else
          flash_type
        end

      html += render_alert_tag(alert_type, flash_msg)
    end.html_safe

  end

  def render_alert_tag(type, msg)
    content_tag(:div, class: "alert alert-#{type}") { msg }
  end
end
