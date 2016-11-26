require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let!(:you) do
    User.create!(email: "you@email.com", password: 'secret123')
  end

  let!(:opponent) do
    User.create!(email: "opponent@email.com", password: 'secret123')
  end

  before do
    allow(request.env['warden']).to receive(:authenticate!).and_return(you)
    allow(controller).to receive(:current_user).and_return(you)
  end

  describe 'POST create' do
    context 'when params are valid' do
      let(:params) do
        {
          date_played: DateTime.now,
          your_score: 21,
          their_score: 19,
          user: you,
          opponent_id: opponent.id
        }
      end

      it 'should create a new Game' do
        expect {
          post :create, { game: params }
        }.to change(Game, :count).by(1)
      end

      it 'should redirect to root path' do
        post :create, { game: params }
        expect(response).to redirect_to('/')
      end
    end

    context 'when params are invalid' do
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
          post :create, { game: params }
        }.to change(Game, :count).by(0)
      end

      it 'should render new view' do
        post :create, { game: params }
        expect(response).to render_template(:new)
      end
    end
  end
end
