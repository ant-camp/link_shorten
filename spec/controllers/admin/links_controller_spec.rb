require 'rails_helper'
#
RSpec.describe Admin::LinksController, type: :controller do

  describe "Before action" do
    it {should use_before_action(:set_link)}
  end

  describe 'GET #show' do
    link = FactoryBot.create(:link, expired: true, original_url: 'http://google.com')
      it "should show link" do
        get :show, params: { id: link.id }
        expect(response).to be_successful
    end
  end

end
