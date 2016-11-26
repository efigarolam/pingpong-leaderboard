class GamesController < ApplicationController
  def new
    @game = Game.new
    @game.user = current_user
  end

  def create
    @game = Game.new(user: current_user)
    @game.update_attributes game_params

    if @game.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(
      :date_played,
      :opponent_id,
      :your_score,
      :their_score
    )
  end
end
