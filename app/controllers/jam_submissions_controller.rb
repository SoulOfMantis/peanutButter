class JamSubmissionsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, :set_jam_submission, only: %i[ show edit update destroy ] 
  def index
    author = User.find_by nickname: params[:nickname]
    @gamejam = Gamejam.find params[:gamejam_id]
    if !author.nil?
      command_ids = author.jam_command_ids
      @jam_submissions = JamSubmission.where(jam_command_id: command_ids)
    elsif !@gamejam.nil?
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

  def new
    @jam_submission = JamSubmission.new
  end

  def create
    @jam_submission = JamSubmission.new(jam_submission_params)
    @jam_submission.jam_command = Current.session.user.jam_command_of_gamejam @jam_submission.gamejam.id
    if @jam_submission.save
      redirect_to [@jam_submission.gamejam, @jam_submission]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if !@jam_submission.authored_by_current_user?
      redirect_to @jam_submission, status: :forbidden
    end
  end

  def update
    if !@jam_submission.authored_by_current_user? 
      render :show, status: :forbidden and return
    end

    if @jam_submission.update(jam_submission_params)
      redirect_to [@jam_submission.gamejam, @jam_submission]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @jam_submission.destroy if @jam_submission.authored_by_current_user?
    redirect_to gamejam_submissions_path(params[:gamejam_id])
  end

  private
    def set_jam_submission
      @jam_submission = JamSubmission.find(params[:id])      
    end

    def jam_submission_params
      params.expect(jam_submission: [ :name, :description])
    end
end
