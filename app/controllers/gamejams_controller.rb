class GamejamsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  def index
    @gamejams = Gamejam.all
  end

  def show
    @gamejam = Gamejam.find(params[:id])
  end

  def new
    @gamejam = Gamejam.new
  end

  def create
    @gamejam = Gamejam.new(gamejam_params)
    @gamejam.author=Current.session.user
    if @gamejam.save
      redirect_to @gamejam
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def gamejam_params
      params.expect(gamejam: [ :name, :theme ])
    end
end
