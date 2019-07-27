# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    client_name { 'client' }
  end
end
