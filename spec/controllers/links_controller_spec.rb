require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe "Before action" do
    it { should use_before_action(:set_link) }
  end

	describe 'POST #create' do
    it "should create and shorten url and redirect" do
      post :create, params: { link: { original_url: 'http://test.com'} }
      expect(Link.last.original_url).to eq 'http://test.com'
      expect(response.response_code).to eq 302
      expect(response).to redirect_to("/links/#{Link.last.id}")
    end
	end

  describe 'GET #forward_to_link' do
    before do
      allow_any_instance_of(Link).to receive(:click_counter).and_return(true)
    end
    context 'valid link' do
      link = FactoryBot.create(:link, expired: false, original_url: 'http://google.com')
      it "should redirect to the original url" do
        get :forward_to_link, params: { hash_key: link.hash_key }
        expect(response.response_code).to eq 301
        expect(response).to redirect_to(link.original_url)
      end

    end

    context 'expired link' do
      link = FactoryBot.create(:link, expired: true, original_url: 'http://google.com')
      it "should render 404 if the link is expired" do
        get :forward_to_link, params: { hash_key: link.hash_key }
        expect(response.response_code).to eq 404
      end
    end
  end

  describe 'GET #show' do
    link = FactoryBot.create(:link, expired: true, original_url: 'http://google.com')
    context 'Should render link/show' do
      it "should show link" do
        get :show, params: { id: link.id }
        expect(response).to be_successful
      end
    end
  end
end
