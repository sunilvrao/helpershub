class CommitmentsController < ApplicationController
  def create
    @commitment = Commitment.new(params[:commitment])
    @commitment.user = current_user
    if(@commitment.save)
      @commitment.request.inc(:commit_count,1)
      @commitment.user.inc(:commit_count,1)
      flash[:notice] = "You have commited to this project successfully"
      redirect_to @commitment.request
    else
      render :action=>:commit, :controller=>:request
    end
  end
end
