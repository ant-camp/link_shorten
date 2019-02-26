require 'rails_helper'

RSpec.describe Stat, type: :model do

  describe "database" do
    it { should have_db_column(:clicks).of_type(:integer) }
    it { should have_db_column(:clicks).with_options(null: false, default: 0) }
    it { should have_db_index(:link_id) }
  end

  describe "associations" do
    it { should belong_to(:link) }
  end

end
