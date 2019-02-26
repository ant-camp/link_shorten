FactoryBot.define do
  factory :link do
    original_url { Faker::Internet.url }
    shorened_url { Faker::Internet.url.slug }
    expired { false }
  end
end
