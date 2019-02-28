require 'rails_helper'

RSpec.describe Link, type: :model do

  describe "database" do
    it { should have_db_column(:original_url) }
    it { should have_db_column(:shortened_url) }
    it { should have_db_column(:expired).of_type(:boolean) }
    it { should have_db_column(:hash_key) }
    it { should have_db_index(:hash_key) }
    it { should have_db_column(:clicks).of_type(:integer) }
  end

  describe "validation" do
    it { should allow_value(Faker::Internet.url).for(:original_url) }
  end

end
