class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_authentic_user, except: %i[index contact]

  def index
    render 'layouts/application', layout: false
  end

  def check_authentic_user
    unless session[:user_id]
      flash[:notice] = 'Please log in'
      redirect_to(controller: 'application', action: 'index')
    end
  end

  def contact
    render 'layouts/contact'
  end
end
