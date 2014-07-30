class WelcomeController < ApplicationController
  before_filter :check_authentic_user, :except => [:index]

  def index
    #@tickets = Ticket.all
    @support = Support.new
    @supports = Support.all

    @roles = Role.all
    @ticket_states = TicketState.all
  end
end