class JamSubmissionsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, only: %i[ show edit update destroy index ] 
  before_action :set_jam_submission, only: %i[ show edit update destroy ] 

  def index
    author = User.find_by nickname: params[:nickname]
    @gamejam = Gamejam.find_by id: params[:gamejam_id]
    if !author.nil?
      command_ids = author.jam_command_ids
      @jam_submissions = JamSubmission.where(jam_command_id: command_ids)
    elsif !@gamejam.nil?
      redirect_to gamejam_path(@gamejam), status: :forbidden and return unless (@gamejam.theme_available?)     
      @jam_submissions = @gamejam.jam_submissions    
    else
      render_404
    end    
  end

  def show
    unless @jam_submission.accessible?
      redirect_to gamejam_submissions_path, status: :forbidden and return
    end
  end

  def edit
    unless @jam_submission.editable?
      redirect_to @jam_submission, status: :forbidden
    end
  end

  def update
    unless @jam_submission.editable?
      render :show, status: :forbidden and return
    end

    if @jam_submission.update(jam_submission_params)
      redirect_to gamejam_submission_path(@jam_submission.joined_jam, @jam_submission)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless @jam_submission.accessible? and @jam_submission.authored_by_current_user?
      render :show, status: :forbidden and return
    end

    @jam_submission.destroy
    redirect_to gamejam_submissions_path(params[:gamejam_id])
  end

  private
    def set_jam_submission
      @jam_submission = JamSubmission.find(params[:id])      
    end

    def jam_submission_params
      params.expect(jam_submission: [ :name, :description, :game_build])
    end
end
