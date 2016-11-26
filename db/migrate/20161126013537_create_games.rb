class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date_played
      t.references :opponent, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :your_score
      t.integer :their_score
      t.boolean :victory

      t.timestamps null: false
    end
  end
end
