class TicketsController < ApplicationController
  before_filter :check_authentic_user, except: [ :new, :show, :create ]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = Ticket.new
  end

  def index
    @cells = Tab.show.pluck(:name, :states)
  end

  def edit
    @supports = Support.all
    @states = TicketState.all
  end

  def update
    if @ticket
      @ticket.assign_attributes(ticket_params)

      # rails dirty attributes
      if @ticket.support_id_changed? || @ticket.ticket_state_id_changed?
        flash[:notice] = 'Ticket state was successfully updated.'
        #NotificationMailer.ticket_status_changed(@ticket).deliver
      end

      if @ticket.save
        redirect_to tickets_path
      else
        render 'edit'
      end
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket
      @ticket.support_id = session[:user_id]
      @ticket.ticket_state_id = TicketState::CUSTOMER

      if @ticket.save
        #NotificationMailer.new_ticket(@ticket).deliver

        flash[:notice] = 'Mail with ticket information was sent on your e-mail address.'
        redirect_to root_path
      else
        render 'new'
      end
    end
  end

  def destroy
    if @ticket
      @ticket.destroy

      session[:user_id].nil? ? redirect_to(root_path) : redirect_to(tickets_path)
    end
  end

  def show
    if @ticket.nil?
      @comments = nil
    else
      @comments = @ticket.comments.select(&:persisted?)
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.where("id = ? OR uuid = ?", params[:id], params[:id]).first!
  end

  def ticket_params
    params.require(:ticket).permit(:username, :email, :subject, :problem, :support_id, :ticket_state_id) if params[:ticket]
  end
end
