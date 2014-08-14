class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_authentic_user, :except => [:index]

  def index
    #@tickets = Ticket.all
    #@support = Support.new
    #@supports = Support.all
    #@roles = Role.all
    #@ticket_states = TicketState.all

    render 'layouts/application', layout: false
  end

  def check_authentic_user
    unless session[:user_id]
      flash[:notice] = 'Please log in'
      redirect_to(:controller => 'application', :action => 'index')
    end
  end
end
