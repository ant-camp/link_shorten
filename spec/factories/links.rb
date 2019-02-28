FactoryBot.define do
  factory :link do
    original_url { Faker::Internet.url }
    shortened_url { Faker::Internet.slug }
    expired { false }
    clicks { 1 }
  end
end
