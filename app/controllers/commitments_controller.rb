class CommitmentsController < ApplicationController
  def create
    @commitment = Commitment.new(params[:commitment])
    @commitment.user = current_user
    if(@commitment.save)
      flash[:notice] = "You have commited to this project successfully"
      redirect_to @commitment.request
    else
      render :action=>:commit, :controller=>:request
    end
  end
end
