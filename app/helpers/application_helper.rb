module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Tropical Oasis"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end


  BOOTSTRAP_FLASH_MSG = {
      success: 'alert-success',
      error: 'alert-error',
      alert: 'alert-block',
      notice: 'alert-info'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym, flash_type.to_s)
  end


  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
               concat message
             end)
    end
    nil
  end

end
