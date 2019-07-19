# == Schema Information
#
# Table name: clicks
#
#  id           :bigint           not null, primary key
#  shortlink_id :bigint
#  ip_address   :string(255)
#  user_agent   :string(255)
#  referer      :string(255)
#  device       :string(255)
#  browser      :string(255)
#  location     :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Click < ApplicationRecord
  belongs_to :shortlink, counter_cache: :click_count
end
