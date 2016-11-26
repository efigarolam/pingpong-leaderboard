require 'rails_helper'

RSpec.describe HistoryController, type: :controller do
  render_views

  let!(:you) do
    User.create!(email: "you@email.com", password: 'secret123')
  end

  before do
    allow(request.env['warden']).to receive(:authenticate!).and_return(you)
    allow(controller).to receive(:current_user).and_return(you)
  end

  describe 'GET index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'when user has 0 games played' do
      it 'renders a message' do
        get :index
        expect(response.body).to match(/You haven't played a match yet./)
      end
    end
  end
end
