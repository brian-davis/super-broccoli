FactoryBot.define do
  factory :shortlink, class: Shortlink do
    source { Faker::Internet.url }
    user { FactoryBot.create(:user) }
  end
end
