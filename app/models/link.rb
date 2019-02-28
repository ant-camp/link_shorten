class Link < ApplicationRecord
  CACHE_SIZE = 50
  URL_REGEX = /\A((http|https):\/\/)*[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  include Redis::Objects
  before_validation :check_and_replace_url_protocal
  validates :original_url, format: { with: URL_REGEX, message: 'Please provider a valid url.' }
  before_create :short_url
  before_create :create_hash_key
  counter :redis_clicks
  after_update :clear_cache


  #Check if original_url has https or https
  def check_and_replace_url_protocal
    url = self.original_url.downcase
    unless url.starts_with?("http://", "https://") && url.include?(".com")
     self.original_url = "http://#{self.original_url}"
    end
  end

  #Loop through generated hash_url until unique
  def create_hash_key
    loop do
      self.hash_key = create_new_hash_key(self.original_url)
      break unless Link.exists?(hash_key: hash_key)
    end
  end

  #Redis fetch link by hash_key
  def self.get_url!(hash_key)
    Rails.cache.fetch(hash_key, expires_in: 1.day) do
      Link.find_by(hash_key: hash_key)
    end
  end

  #Redis update clicks if cache reached
  def click_counter
    redis_count = self.redis_clicks
    redis_count.increment
    clicks = redis_count.value
    if clicks >= CACHE_SIZE
      self.update_attribute(:clicks, clicks)
      redis_count.clear
    end
  end

  #Click count from db & redis counter
  def actual_count
    redis_count = self.redis_clicks.value
    db_count = self.clicks || 0
    redis_count + db_count
  end

  #Clear link cache
  def clear_cache
    Rails.cache.delete(self.hash_key)
  end

  private

  #Generate short url by random hexidemical
  def short_url
    loop do
      self.shortened_url = SecureRandom.hex(3)
      break unless Link.exists?(shortened_url: shortened_url)
    end
  end

  #Generate new hash_key
  def create_new_hash_key(original_url)
    salt = SecureRandom.hex(1)
    self.hash_key = Digest::SHA1.hexdigest(salt + self.original_url)
  end

end
