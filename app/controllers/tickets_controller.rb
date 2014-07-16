class TicketsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :new, :show, :show_by_uuid, :create, :authenticate ]

  def new
    @ticket = Ticket.new
    @ticket.status_id = 0 # 'Waiting for Staff Response'
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])

    if @ticket.update(ticket_params)
      redirect_to @ticket
    else
      render 'edit'
    end
  end

  def index
    @tickets = Ticket.all
  end

  def create
    @ticket = Ticket.new(ticket_params)

    @ticket.status_id = 0 # 'Waiting for Staff Response'
    @ticket.owner_id = session[:user_id]

    # generate unique url
    alpha = (:A..:Z).to_a.shuffle[0,9].join
    digit = (0..9).to_a.shuffle[0,6].join
    url = alpha[0,3] + digit[0,3] + alpha[3,3] + digit[3,3] + alpha[6,3]
    @ticket.uuid = url

    if @ticket.save
      redirect_to @ticket
    else
      render 'new'
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    if @ticket.owner_id
      redirect_to tickets_path
    else
      redirect_to ticket_show_by_uuid_path
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def show_by_uuid
    # puts '=== params: ', params.inspect
    if params[:commit] == 'Find'
      @ticket = Ticket.find_by(uuid: params[:tickets][:uuid])
    else
      @ticket = Ticket.find_by(uuid: params[:uuid])
    end
  end

private
  def ticket_params
    params.require(:ticket).permit(:username, :email, :subject, :problem)
  end
end

