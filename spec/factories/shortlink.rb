FactoryBot.define do
  factory :shortlink, class: Shortlink do
    source { Faker::Internet.url }
  end
end
