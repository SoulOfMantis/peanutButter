class GamejamsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, :set_gamejam, only: %i[ show edit update destroy ] 
  def index
    @gamejams = Gamejam.all
  end

  def show
    unless @gamejam.published? or @gamejam.authored_by_current_user?
      redirect_to gamejams_path, status: :forbidden and return
    end
  end

  def new
    @gamejam = Gamejam.new
  end

  def create
    @gamejam = Gamejam.new(gamejam_params)
    @gamejam.start_date = params[:gamejam][:starts_in].to_i.days.from_now
    @gamejam.end_date = @gamejam.start_date + params[:gamejam][:lasts_for].to_i.days
    @gamejam.author = Current.session.user
    if @gamejam.save
      redirect_to @gamejam
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if !@gamejam.authored_by_current_user?
      redirect_to @gamejam, status: :forbidden
    end
  end

  def update
    if @gamejam.update(gamejam_params)
      redirect_to @gamejam
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gamejam.destroy if @gamejam.authored_by_current_user? 
    redirect_to gamejams_path
  end

  private
    def set_gamejam
      @gamejam = Gamejam.find(params[:id])      
    end

    def gamejam_params
      params.expect(gamejam: [ :name, :description, :theme, :status ])
    end
end
