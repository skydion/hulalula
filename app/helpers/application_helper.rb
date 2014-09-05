module ApplicationHelper
  def admin_area(&block)
    content_tag(:span, :class => 'admin', &block) if admin?
  end

  def admin?
    session[:role_name] == 'admin'
  end

  def authorized?
    !session[:user_id].nil?
  end

  def header_data(&block)
    content_tag(:header, class: 'index_header') do
      content_tag(:span, class: 'index_header_text', &block)
    end
  end
end
