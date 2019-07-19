# == Schema Information
#
# Table name: clicks
#
#  id           :bigint           not null, primary key
#  shortlink_id :bigint
#  ip_address   :string(255)
#  user_agent   :string(255)
#  referer      :string(255)
#  device       :integer
#  browser      :integer
#  location     :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  platform     :integer
#

class Click < ApplicationRecord
  belongs_to :shortlink, counter_cache: :click_count

  before_create :set_device
  before_create :set_browser
  before_create :set_platform
  # before_create :set_location # TODO

  scope :last_24_hours, -> { where({ created_at: (24.hours.ago..Time.now) }) }
  scope :last_7_days, -> { where({ created_at: (7.days.ago..Time.now) }) }
  scope :last_30_days, -> { where({ created_at: (30.days.ago..Time.now) }) }

  enum browser: [
    :nokia, :uc_browser, :phantom_js,
    :blackberry_browser, # this is an override for :blackberry
    :opera, :edge, :ie, :firefox, :otter, :facebook, :instagram, :weibo, :qq, :alipay, :electron,
    :chrome, :safari, :micro_messenger, :generic
  ]

  enum device: [
    :xbox_one, :xbox_360, :surface, :tv, :playbook, :wiiu, :wii, :switch, :kindle_fire, :kindle,
    :ps4, :ps3, :psvita, :psp, :ipad, :iphone, :ipod_touch, :unknown
  ]

  enum platform: [
    :adobe_air, :chrome_os, :windows_mobile, :windows_phone, :android, :blackberry, :ios, :mac,
    :firefox_os, :windows, :linux, :other
  ]

  scope :desktop, -> { where(platform: [:chrome_os, :mac, :windows, :linux]) }
  scope :mobile, -> {
    where(platform: [:windows_mobile, :windows_phone, :android, :blackberry, :ios, :firefox_os])
  }

  def user_agent_inspector
    @user_agent_inspector ||= Browser.new(user_agent)
  end

  private

  # def set_location
  #   # TODO
  # end

  def set_device
    self.device = user_agent_inspector.device.id
  end

  def set_browser
    self.browser = case user_agent_inspector
                   when Browser::BlackBerry
                     # override this because of a duplicate :blackberry name in enums
                     :blackberry_browser
                   else
                     user_agent_inspector.id
                   end
  end

  def set_platform
    self.platform = user_agent_inspector.platform.id
  end
end
