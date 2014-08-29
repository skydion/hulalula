class CommentsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :create ]

=begin
  def new
    @comment = CommentsController.new
  end
=end

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.create(comment_params)

    NotificationMailer.new_comment(@ticket, @comment).deliver

    if @ticket.support_id
      redirect_to ticket_path(@ticket)
    else
      redirect_to '/ticket/' + @ticket.uuid.to_s
    end
  end

  def destroy
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.find(params[:id])
    @comment.destroy

    if @ticket.support_id
      redirect_to ticket_path(@ticket)
    else
      redirect_to '/ticket/' + @ticket.uuid.to_s
    end
  end

private
  def comment_params
    params.require(:comment).permit(:body, :owner_id) if params[:comment]
  end
end

