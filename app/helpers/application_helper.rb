module ApplicationHelper
  def admin_area(&block)
    content_tag(:div, :class => 'admin', &block) if admin?
  end

  def admin?
    session[:role_name] == 'admin'
  end

  def authorized?
    !session[:user_id].nil?
  end
end
