class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_be_activated!
  def create
    @request = Request.where(:slug=>params[:request_id]).first
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.commentable = @request
    if(@comment.save)
      redirect_to @request, :notice=>"You have commented successfully"
    else
      @comments = @request.comments
      render :action=>:show, :controller=>"requests"
    end
  end
end
