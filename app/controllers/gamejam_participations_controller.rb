class GamejamParticipationsController < ApplicationController

  def create
    @gamejam_participation = GamejamParticipation.create! gamejam_participation_params
  end

  private
    def gamejam_participation_params
      params.expect(gamejam_participation: [ :joined_gamejam_id, :participant_id ])
    end
end
