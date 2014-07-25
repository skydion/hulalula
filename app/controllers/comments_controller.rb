class CommentsController < ApplicationController
  def create
    @ticket = Ticket.find(params[:ticket_id])

    @comment = @ticket.comments.create(comment_params)

    puts '=== Comment inspect', @comment.inspect

    # TODO - send email with comment to the customer

    # puts '=== Comment::create: ' + @ticket.support_id.to_s + ' uuid: ' + @ticket.uuid.to_s
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

