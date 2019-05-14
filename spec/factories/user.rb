FactoryBot.define do
  factory :user, class: User do
    client_name { %w[idlife avon worldventures tupperware stampinup].sample }
  end
end
