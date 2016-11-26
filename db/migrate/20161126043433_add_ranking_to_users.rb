class AddRankingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ranking, :integer, default: 1
  end
end
