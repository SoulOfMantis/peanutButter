class GamejamsController < ApplicationController
  def index
    @gamejams = Gamejam.all
  end

  def show
    @gamejam = Gamejam.find(params[:id])
  end
end
