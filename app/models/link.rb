class Link < ApplicationRecord
  before_validation :check_and_replace_url_protocal
  # URL_REXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

  #validates original_url is a url
  # validates :original_url, format: { with: URL_REXP }

  #before create genereate short url
  before_create :short_url
  #check if link is expired or not
  scope :expired?, -> {where(expired: true)}
  has_one :stat

  #check if original_url has https or https
  def check_and_replace_url_protocal
    #downcase the url
    url = self.original_url.downcase
    #if url doesnt start with https or https
    unless url.starts_with?("http://", "https://") && url.include?(".com")
      #set original url to have http
     self.original_url = "http://#{self.original_url}"
    end
  end

  def short_url
    random_hex = SecureRandom.hex(3)
    self.shortened_url = random_hex
  end

end
