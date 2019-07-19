# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  client_name :string(255)      not null
#  auth_token  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# User is the Auth model for the JSON API.  User is a multitenancy corporate client, not an
# individual client user.  Individual metrics can be determined client-side (scope the 'source'
# link to that user.)
class User < ApplicationRecord
  has_secure_token :auth_token

  has_many :shortlinks, dependent: :destroy
  has_many :clicks, through: :shortlinks
end
