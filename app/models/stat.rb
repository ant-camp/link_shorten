class Stat < ApplicationRecord
  belongs_to :link

  def clicks_counter
    self.clicks + 1
    self.save
  end
end
