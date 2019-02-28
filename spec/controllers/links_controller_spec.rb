require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:valid_attributes) do
      {
        link: {
          original_url: Faker::Internet.url,
          shortened_url: Faker::Internet.slug,
          hash_key: Faker::Alphanumeric.alpha
        }
      }.to_json
    end

    describe "GET #show" do
      it "returns a success response" do
        link = Link.create! valid_attributes
        get :show, params: {id: link.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

  # describe "GET #new" do
  #   it "returns a success response" do
  #
  #   end
  # end
  #

end
