class JamCommandsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, only: %i[ show edit update destroy index ] 
  before_action :set_jam_command, only: %i[ show edit update destroy ] 

  def index
    author = User.find_by nickname: params[:nickname]
    @gamejam = Gamejam.find_by id: params[:gamejam_id]
    if !author.nil?
      @jam_commands = author.jam_commands
    elsif !@gamejam.nil?
      redirect_to gamejam_path(@gamejam), status: :forbidden and return unless @gamejam.accessible?      
      @jam_commands = @gamejam.jam_commands
    else
      render_404
    end    
  end

  def show
    unless @jam_command.accessible?
      redirect_to gamejam_commands_path(@jam_command.joined_jam), status: :forbidden and return
    end
  end

  def new
    unless (Gamejam.find params[:gamejam_id]).accessible?
      redirect_to gamejam_commands_path(params[:gamejam_id]), status: :forbidden and return
    end   
 
    @jam_command = JamCommand.new
  end

  def create
    @jam_command = JamCommand.new(jam_command_params)
    @jam_command.members << Current.session.user
    @jam_command.joined_jam = Gamejam.find params[:gamejam_id]
    unless @jam_command.accessible? and !(@jam_command.joined_jam.authored_by_current_user?)
      redirect_to gamejam_commands_path(@jam_command.joined_jam), status: :forbidden and return
    end    

    if @jam_command.save
      redirect_to gamejam_command_path(@jam_command.joined_jam, @jam_command)
      @jam_command.create_jam_submission({ name: "#{@jam_command.name}'s submission"})
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    unless @jam_command.accessible? and @jam_command.authored_by_current_user?
      render :show, status: :forbidden and return
    end
  end

  def update
    unless @jam_command.accessible? and @jam_command.authored_by_current_user?
      render :show, status: :forbidden and return
    end

    if @jam_command.update(jam_command_params)
      redirect_to gamejam_command_path(@jam_command.joined_jam, @jam_command)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless @jam_command.accessible? and @jam_command.authored_by_current_user?
      render :show, status: :forbidden and return
    end

    @jam_command.destroy
    redirect_to gamejam_commands_path(params[:gamejam_id])
  end

  private
    def set_jam_command
      @jam_command = JamCommand.find(params[:id])      
    end

    def jam_command_params
      params.expect(jam_command: [ :name, :description])
    end
end
