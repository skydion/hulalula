class TicketsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :new, :show, :show_by_uuid, :create ]

  def new
    @ticket = Ticket.new
  end

  def index
    @tickets = Ticket.all
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @supports = Support.all
    @states = TicketState.all
  end

  def update
    @ticket = Ticket.find(params[:id])

    if @ticket
      # TODO - check owner and state changing between comments and email if one of them is changed
      old_support_id = @ticket.support_id
      old_ticket_state_id = @ticket.ticket_state_id

      new_support_id = params[:ticket][:support_id].to_i
      new_ticket_state_id = params[:ticket][:ticket_state_id].to_i

      @ticket.update_attribute :support_id, new_support_id
      @ticket.update_attribute :ticket_state_id, new_ticket_state_id

      if @ticket.update(ticket_params)
        if (old_support_id != new_support_id) || (old_ticket_state_id != new_ticket_state_id)
          NotificationMailer.ticket_status_changed(@ticket).deliver
        end

        redirect_to @ticket
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
        flash[:notice] = 'Mail with ticket url, and unique UUID send, to your e-mail address'

        NotificationMailer.new_ticket(@ticket).deliver

        redirect_to @ticket
      else
        render 'new'
      end
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])

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
    @ticket = Ticket.find(params[:id])

    @support = Support.find_by(id: @ticket.support_id)
  end

  def show_by_uuid
    @ticket = Ticket.find_by(uuid: params[:uuid])

    if @ticket.nil?
      flash[:notice] = 'Wrong UUID, please re-check and try again'
      redirect_to :controller => 'application', :action => 'index'
    else
      @support = Support.find_by(id: @ticket.support_id)
      @status = TicketState.find_by(id: @ticket.ticket_state_id)

      redirect_to @ticket
    end
  end

private
  def ticket_params
    params.require(:ticket).permit(:username, :email, :subject, :problem, :support_id, :ticket_state_id) if params[:ticket]
  end
end
