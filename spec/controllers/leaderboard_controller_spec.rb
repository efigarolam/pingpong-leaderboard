require 'rails_helper'

RSpec.describe LeaderboardController, type: :controller do
  let!(:you) do
    User.create!(email: "you@email.com", password: 'secret123')
  end

  before do
    allow(request.env['warden']).to receive(:authenticate!).and_return(you)
    allow(controller).to receive(:current_user).and_return(you)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
