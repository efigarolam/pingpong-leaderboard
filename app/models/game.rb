class Game < ActiveRecord::Base
  DEFAULT_SCORE_PER_GAME = 50

  belongs_to :opponent, class_name: User
  belongs_to :user

  validates :date_played, :your_score, :their_score, :user, :opponent, presence: true
  validates :your_score, :their_score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :scores_meet_rules

  after_validation :set_victory
  after_save :set_users_score, :update_rankings

  private

  def set_users_score
    if self.victory?
      set_winner_score
    else
      set_opponent_score
    end
  end

  def set_winner_score
    user_ranking = user.ranking
    opponent_ranking = opponent.ranking

    if user_ranking >= opponent_ranking
      user.score += DEFAULT_SCORE_PER_GAME
    else
      difference = opponent_ranking - user_ranking
      user.score += DEFAULT_SCORE_PER_GAME * difference
    end

    user.save
  end

  def set_opponent_score
    user_ranking = user.ranking
    opponent_ranking = opponent.ranking

    if opponent_ranking >= user_ranking
      opponent.score += DEFAULT_SCORE_PER_GAME
    else
      difference = user_ranking - opponent_ranking
      opponent.score += DEFAULT_SCORE_PER_GAME * difference
    end

    opponent.save
  end

  def update_rankings
    users = User.all.order('score DESC')

    users.each_with_index do |user, index|
      user.update_attribute :ranking, index + 1
    end
  end

  def set_victory
    self.victory =  self.your_score > self.their_score
  end

  def scores_meet_rules
    difference = (self.your_score - self.their_score).abs

    if difference < 2
      errors.add(:scores, "don't meet the rules")
    end
  end
end
