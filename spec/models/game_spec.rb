require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#create' do
    context 'when params are valid' do
      let(:you) do
        User.create!(email: "you@email.com", password: 'secret123')
      end

      let(:opponent) do
        User.create!(email: "opponent@email.com", password: 'secret123')
      end

      let(:params) do
        {
          date_played: DateTime.now,
          your_score: 21,
          their_score: 19,
          user: you,
          opponent: opponent
        }
      end

      it 'should create a new Game' do
        expect {
          Game.create(params)
        }.to change(Game, :count).by(1)
      end
    end

    context 'when params are invalid' do
      let(:you) do
        User.create!(email: "you@email.com", password: 'secret123')
      end

      let(:opponent) do
        User.create!(email: "opponent@email.com", password: 'secret123')
      end

      let(:params) do
        {
          date_played: DateTime.now,
          user: you,
          your_score: 21,
          their_score: 20,
          opponent: opponent
        }
      end

      it 'should not create a new Game' do
        expect {
          Game.create(params)
        }.to change(Game, :count).by(0)
      end
    end
  end
end
