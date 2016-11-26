class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  def games
    Game.where('opponent_id = ? OR user_id = ?', id, id)
  end
end
