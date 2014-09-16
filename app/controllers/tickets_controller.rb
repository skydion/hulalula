class TicketsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :new, :show_by_uuid, :create ]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = Ticket.new
  end

  def index
    #@ids = [ [1], [2], [3], [4, 5] ]
    #@cell_headers = ['LT [unassigned]', 'RT [opened]', 'LB [on hold]', 'RB [closed]']

    #@ids = Tab.pluck(:states)
    #@cell_headers = Tab.pluck(:name)
    @cells = Tab.pluck(:name, :states)

    if @cells.length > 4
      render 'tickets/tabs_index'
    else
      render 'tickets/cells_index'
    end
  end

  def edit
    @supports = Support.all
    @states = TicketState.all
  end

  def update
    if @ticket
      old_support_id = @ticket.support_id
      old_ticket_state_id = @ticket.ticket_state_id

      new_support_id = params[:ticket][:support_id].to_i
      new_ticket_state_id = params[:ticket][:ticket_state_id].to_i

      if @ticket.update(ticket_params)
        if (old_support_id != new_support_id) || (old_ticket_state_id != new_ticket_state_id)
          flash[:notice] = 'Ticket state was successfully updated.'
          #NotificationMailer.ticket_status_changed(@ticket).deliver
        end

        redirect_to :controller => 'tickets'
      else
        render 'edit'
      end
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket
      @ticket.support_id = session[:user_id]
      @ticket.ticket_state_id = 1 # 'Waiting for Staff Response'

      # generate unique url
      alpha = (:A..:Z).to_a.shuffle[0,9].join
      digit = (0..9).to_a.shuffle[0,6].join
      @ticket.uuid = alpha[0,3] + digit[0,3] + alpha[3,3] + digit[3,3] + alpha[6,3]

      if @ticket.save
        #NotificationMailer.new_ticket(@ticket).deliver

        flash[:notice] = 'Mail with ticket information was sent on your e-mail address.'
        redirect_to '/'
      else
        render 'new'
      end
    end
  end

  def destroy
    if @ticket
      @ticket.destroy

      if session[:user_id].nil?
        redirect_to root_path
      else
        redirect_to tickets_path
      end
    end
  end

  def show
    if @ticket.nil?
      @comments = nil
    else
      @comments = @ticket.comments.select(&:persisted?)
    end
  end

  def show_by_uuid
    @ticket = Ticket.find_by(uuid: params[:uuid])

    if @ticket.nil?
      flash[:alert] = 'Wrong UUID, please re-check and try again.'
      redirect_to :controller => 'application'
    else
      @comments = @ticket.comments.select(&:persisted?)
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:username, :email, :subject, :problem, :support_id, :ticket_state_id) if params[:ticket]
  end
end
