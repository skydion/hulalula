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
      # TODO - check owner and state changing between comments and end email if one of them is changed
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
    # @tickets = Ticket.all
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
        flash[:notice] = 'Mail with ticket url, and unique UUID send, to your e-mail address'
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
      support_id = @ticket.support_id
      #puts '=== support_id: ' + support_id.to_s

      @ticket.destroy

      if support_id
        redirect_to tickets_path
      else
        redirect_to welcome_index_path
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
      redirect_to :controller => 'welcome', :action => 'index'
    else
      @support = Support.find_by(id: @ticket.support_id)
      @status = TicketState.find_by(id: @ticket.ticket_state_id)
    end
  end

  def get_tickets(state_name)

    @status = case state_name
                when 'unassigned'
                  TicketState.find_by('name = ? OR name = ?', 'Waiting for staff responce', 'Waiting for customer')
                when 'opened'
                  TicketState.find_by(name: 'On hold')
                when 'cancelled'
                  TicketState.find_by(name: 'Cancelled')
                when 'closed'
                  TicketState.find_by(name: 'Completed')
                else
                  @status = nil
              end

    if @status
      @tickets = Ticket.find_by(ticket_state_id: @status.id)
      # puts '=== tickets [1]: ' + @tickets.inspect.to_s
    end

    return @tickets
  end

private
  def ticket_params
    params.require(:ticket).permit(:username, :email, :subject, :problem, :support_id, :ticket_state_id) if params[:ticket]
  end
end
