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

  before_create :set_device
  before_create :set_browser
  # before_create :set_location # TODO

  scope :last_24_hours, -> { where({ created_at: (24.hours.ago..Time.now) }) }
  scope :last_7_days, -> { where({ created_at: (7.days.ago..Time.now) }) }
  scope :last_30_days, -> { where({ created_at: (30.days.ago..Time.now) }) }

  # enum :browser_id

  def user_agent_inspector
    @user_agent_inspector ||= Browser.new(user_agent)
  end

  private

  # def set_location
  #   # TODO
  # end

  def set_device
    self.device = user_agent_inspector.device_or_desktop
  end

  def set_browser
    self.browser = user_agent_inspector.name
  end
end
