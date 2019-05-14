class User < ApplicationRecord
  has_secure_token :auth_token

  has_many :shortlinks
end
