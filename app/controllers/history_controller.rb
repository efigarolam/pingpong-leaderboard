class HistoryController < ApplicationController
  def index
    @games = current_user.games.includes(:opponent).order('date_played DESC')
  end
end
