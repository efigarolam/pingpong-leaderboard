class AddDefaultToGamesScores < ActiveRecord::Migration
  def change
    change_column :games, :your_score, :integer, default: 0
    change_column :games, :their_score, :integer, default: 0
  end
end
