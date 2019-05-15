# frozen_string_literal: true

FactoryBot.define do
  factory :shortlink, class: Shortlink do
    source { Faker::Internet.url }
    user { FactoryBot.create(:user) }
  end
end
