class Game < ActiveRecord::Base
  belongs_to :opponent, class_name: User
  belongs_to :user

  validates :date_played, :your_score, :their_score, :user, :opponent, presence: true
  validates :your_score, :their_score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :scores_meet_rules

  private

  def scores_meet_rules
    difference = (self.your_score - self.their_score).abs

    if difference < 2
      errors.add(:scores, "don't meet the rules")
    end
  end
end
