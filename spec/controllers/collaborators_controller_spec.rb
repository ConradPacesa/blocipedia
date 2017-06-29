require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:my_wiki) { create(:wiki, user: my_user) }
  let(:private_wiki) { create(:wiki, user: my_user, private: true) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
