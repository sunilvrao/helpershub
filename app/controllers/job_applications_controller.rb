class JobApplicationsController < ApplicationController
  def create
    @job_application = JobApplication.new(params[:job_application])
    @job_application.user = current_user
    if(@job_application.save)
      flash[:notice] = "Application successfully created"
      redirect_to @job_application.job
    else
      render :action=>:apply, :controller=>:jobs
    end
  end
end
