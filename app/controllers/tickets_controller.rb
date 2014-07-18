class TicketsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :new, :show, :show_by_uuid, :create, :authenticate ]

  def new
    @ticket = Ticket.new
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @supports = Support.all
    @states = TicketState.all
  end

  def update
    @ticket = Ticket.find(params[:id])

    if @ticket
      # puts '=== ticket::update'
      @ticket.update_attribute :support_id, params[:support_id]
      @ticket.update_attribute :ticket_state_id, params[:ticket_state_id]

      if @ticket.update(ticket_params)
        redirect_to @ticket
      else
        render 'edit'
      end
    end
  end

  def index
    @tickets = Ticket.all
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket
      @ticket.support_id = session[:user_id]
      @ticket.ticket_state_id = 1 # 'Waiting for Staff Response'

      # generate unique url
      alpha = (:A..:Z).to_a.shuffle[0,9].join
      digit = (0..9).to_a.shuffle[0,6].join
      url = alpha[0,3] + digit[0,3] + alpha[3,3] + digit[3,3] + alpha[6,3]
      @ticket.uuid = url

      if @ticket.save
        # TODO - send email to the customer
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

      if @ticket.support_id
        redirect_to tickets_path
      else
        redirect_to ticket_show_by_uuid_path
      end
    end
  end

  def show
    @ticket = Ticket.find(params[:id])

    @support = Support.find_by(id: @ticket.support_id)
  end

  def show_by_uuid
    # puts '=== params: ', params.inspect
    if params[:commit] == 'Find'
      @ticket = Ticket.find_by(uuid: params[:tickets][:uuid])
    else
      @ticket = Ticket.find_by(uuid: params[:uuid])
    end

    @support = Support.find_by(id: @ticket.support_id)
    @status = TicketState.find_by(id: @ticket.ticket_state_id)
  end

private
  def ticket_params
    params.require(:ticket).permit(:username, :email, :subject, :problem, :support_id, :ticket_state_id) if params[:ticket]
  end
end
