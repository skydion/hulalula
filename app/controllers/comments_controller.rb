class CommentsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :create ]

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.build(comment_params)

    if @comment.owner_id
      @ticket.ticket_state_id = TicketState::SUPPORT
    else
      @ticket.ticket_state_id = TicketState::CUSTOMER
    end
    @ticket.save

    if @comment
      #NotificationMailer.new_comment(@ticket, @comment).deliver

      if @comment.owner_id
        redirect_to ticket_path(@ticket)
      else
        redirect_to ticket_path(@ticket.uuid.to_s)
      end
    end
  end

  def destroy
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.find(params[:id])

    if @comment
      owner_id = @comment.owner_id

      @comment.destroy

      if owner_id
        redirect_to ticket_path(@ticket)
      else
        redirect_to ticket_path(@ticket.uuid.to_s)
      end
    end
  end

private
  def comment_params
    params.require(:comment).permit(:body, :owner_id) if params[:comment]
  end
end

