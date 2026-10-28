class GamejamsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, :set_gamejam, only: %i[ show edit update destroy ] 
  def index
    @gamejams = Gamejam.all
  end

  def show
  end

  def new
    @gamejam = Gamejam.new
  end

  def create
    @gamejam = Gamejam.new(gamejam_params)
    @gamejam.author = Current.session.user
    if @gamejam.save
      redirect_to @gamejam
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @gamejam.update(gamejam_params)
      redirect_to @gamejam
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gamejam.destroy 
    redirect_to gamejams_path
  end

  private
    def set_gamejam
      @gamejam = Gamejam.find(params[:id])      
    end

    def gamejam_params
      params.expect(gamejam: [ :name, :description, :theme, :start_date, :end_date, :status ])
    end
end
