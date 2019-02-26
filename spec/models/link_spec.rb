require 'rails_helper'

RSpec.describe Link, type: :model do

  describe "database" do
    it { should have_db_column(:original_url) }
    it { should have_db_column(:shortened_url) }
    it { should have_db_column(:expired).of_type(:boolean) }
  end

  describe "validation" do
    it { should allow_value(Faker::Internet.url).for(:original_url) }

  end

  describe "associations" do
    it { should have_one(:stat) }

  end

end
