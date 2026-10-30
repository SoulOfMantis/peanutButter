class JamSubmissionsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, :set_jam_submission, only: %i[ show edit update destroy ] 
  def index
    @jam_submissions = JamSubmission.where(gamejam_id: params[:gamejam_id])
    @gamejam = Gamejam.find(params[:gamejam_id])
  end

  def show
  end

  def new
    @jam_submission = JamSubmission.new
  end

  def create
    @jam_submission = JamSubmission.new(jam_submission_params)
    @jam_submission.author = Current.session.user
    @jam_submission.gamejam = Gamejam.find params[:gamejam_id]
    if @jam_submission.save
      redirect_to [@jam_submission.gamejam, @jam_submission]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @jam_submission.update(jam_submission_params)
      redirect_to [@jam_submission.gamejam, @jam_submission]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @jam_submission.destroy 
    redirect_to gamejam_jam_submissions_path(params[:gamejam_id])
  end

  private
    def set_jam_submission
      @jam_submission = JamSubmission.find(params[:id])      
    end

    def jam_submission_params
      params.expect(jam_submission: [ :name, :description])
    end
end
