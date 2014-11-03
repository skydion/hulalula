class CommentsController < ApplicationController
  before_filter :check_authentic_user, except: [ :create ]
  before_action :set_ticket, only: [:create, :destroy]

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.owner_id = session[:user_id]

    if @comment.owner_id
      @ticket.ticket_state_id = TicketState::SUPPORT
    else
      @ticket.ticket_state_id = TicketState::CUSTOMER
    end

    @ticket.save

    if @comment
      #NotificationMailer.new_comment(@ticket, @comment).deliver
    end

    session[:user_id] ? redirect_to(ticket_path(@ticket)) : redirect_to(ticket_path(@ticket.uuid.to_s))
  end

  def destroy
    @comment = @ticket.comments.find(params[:id])

    if @comment
      @comment.destroy
    end

    session[:user_id] ? redirect_to(ticket_path(@ticket)) : redirect_to(ticket_path(@ticket.uuid.to_s))
  end

private
  def set_ticket
    @ticket = Ticket.where(id: params[:ticket_id]).first
  end

  def comment_params
    params.require(:comment).permit(:body) if params[:comment]
  end
end

