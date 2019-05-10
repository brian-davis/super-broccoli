FactoryBot.define do
  factory :shortlink, class: Shortlink do
    source { "http://www.example.com" }
  end
end
