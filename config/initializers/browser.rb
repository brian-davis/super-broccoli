require 'browser/aliases'
Browser::Base.include(Browser::Aliases)

# > c = Click.last
#   Click Load (0.9ms)  SELECT  `clicks`.* FROM `clicks` ORDER BY `clicks`.`id` DESC LIMIT 1
# => #<Click id: 3, shortlink_id: 12, ip_address: "10.150.147.103", user_agent: "Mozilla/5.0 (iPhone; CPU iPhone OS 12_3_1 like Mac...", referer: nil, device: nil, browser: nil, location: nil, created_at: "2019-07-19 17:51:21", updated_at: "2019-07-19 17:51:21">

# > b = Browser.new(c.user_agent)
# > pp (b.methods - Object.methods).sort
# [:accept_language,
#  :adobe_air?,
#  :alipay?,
#  :android?,
#  :blackberry?,
#  :blackberry_playbook?,
#  :bot,
#  :bot?,
#  :chrome?,
#  :chrome_os?,
#  :compatibility_view?,
#  :console?,
#  :core_media?,
#  :device,
#  :edge?,
#  :electron?,
#  :facebook?,
#  :firefox?,
#  :firefox_os?,
#  :full_version,
#  :id,
#  :ie?,
#  :instagram?,
#  :ios?,
#  :ios_app?,
#  :ios_webview?,
#  :ipad?,
#  :iphone?,
#  :ipod_touch?,
#  :kindle?,
#  :kindle_fire?,
#  :known?,
#  :linux?,
#  :mac?,
#  :match?,
#  :meta,
#  :micro_messenger?,
#  :mobile?,
#  :modern?,
#  :msie_full_version,
#  :msie_version,
#  :nintendo?,
#  :nintendo_switch?,
#  :nintendo_wii?,
#  :nintendo_wiiu?,
#  :nokia?,
#  :opera?,
#  :opera_mini?,
#  :otter?,
#  :phantom_js?,
#  :platform,
#  :playbook?,
#  :playstation3?,
#  :playstation4?,
#  :playstation?,
#  :playstation_vita?,
#  :proxy?,
#  :ps3?,
#  :ps4?,
#  :psp?,
#  :psp_vita?,
#  :quicktime?,
#  :safari?,
#  :safari_webapp_mode?,
#  :silk?,
#  :surface?,
#  :tablet?,
#  :to_a,
#  :tv?,
#  :ua,
#  :uc_browser?,
#  :version,
#  :vita?,
#  :webkit?,
#  :webkit_full_version,
#  :wechat?,
#  :weibo?,
#  :wii?,
#  :wiiu?,
#  :windows10?,
#  :windows7?,
#  :windows8?,
#  :windows8_1?,
#  :windows?,
#  :windows_mobile?,
#  :windows_phone?,
#  :windows_rt?,
#  :windows_touchscreen_desktop?,
#  :windows_vista?,
#  :windows_wow64?,
#  :windows_x64?,
#  :windows_x64_inclusive?,
#  :windows_xp?,
#  :xbox?,
#  :xbox_360?,
#  :xbox_one?,
#  :yandex?]

# > b.meta
# => ["iphone", "safari", "ios", "mobile", "modern", "safari12", "webkit"]

# > b.name
# => "Safari"

# > b.device.name
# => "iPhone"

# > b.mobile?
# => true

# > pp Browser.matchers.map { |b| [b.new('').id, b.new('').name] }.to_h
# {:nokia=>"Nokia S40 Ovi Browser",
#  :uc_browser=>"UCBrowser",
#  :phantom_js=>"PhantomJS",
#  :blackberry=>"BlackBerry",
#  :opera=>"Opera",
#  :edge=>"Microsoft Edge",
#  :ie=>"Internet Explorer",
#  :firefox=>"Firefox",
#  :otter=>"Otter",
#  :facebook=>"Facebook",
#  :instagram=>"Instagram",
#  :weibo=>"Weibo",
#  :qq=>"QQ Browser",
#  :alipay=>"Alipay",
#  :electron=>"Electron",
#  :chrome=>"Chrome",
#  :safari=>"Safari",
#  :micro_messenger=>"MicroMessenger",
#  :generic=>"Generic Browser"}
# > Browser.matchers.map { |b| b.new('').id }
# => [:nokia, :uc_browser, :phantom_js, :blackberry, :opera, :edge, :ie, :firefox, :otter, :facebook, :instagram, :weibo, :qq, :alipay, :electron, :chrome, :safari, :micro_messenger, :generic]


# > pp Browser::Device.matchers.map { |b| [b.new('').id, b.new('').name] }.to_h
# {:xbox_one=>"Xbox One",
#  :xbox_360=>"Xbox 360",
#  :surface=>"Microsoft Surface",
#  :tv=>"TV",
#  :playbook=>"BlackBerry Playbook",
#  :wiiu=>"Nintendo WiiU",
#  :wii=>"Nintendo Wii",
#  :switch=>"Nintendo Switch",
#  :kindle_fire=>"Kindle Fire",
#  :kindle=>"Kindle",
#  :ps4=>"PlayStation 4",
#  :ps3=>"PlayStation 3",
#  :psvita=>"PlayStation Vita",
#  :psp=>"PlayStation Portable",
#  :ipad=>"iPad",
#  :iphone=>"iPhone",
#  :ipod_touch=>"iPod Touch",
#  :unknown=>"Unknown"}
# > Browser::Device.matchers.map { |b| b.new('').id }
# => [:xbox_one, :xbox_360, :surface, :tv, :playbook, :wiiu, :wii, :switch, :kindle_fire, :kindle, :ps4, :ps3, :psvita, :psp, :ipad, :iphone, :ipod_touch, :unknown]


# > pp Browser::Platform.matchers.map { |b| [b.new('').id, b.new('').name] }.to_h
# {:adobe_air=>"Adobe AIR",
#  :chrome_os=>"Chrome OS",
#  :windows_mobile=>"Windows Mobile",
#  :windows_phone=>"Windows Phone",
#  :android=>"Android",
#  :blackberry=>"BlackBerry",
#  :ios=>"iOS ()",
#  :mac=>"Macintosh",
#  :firefox_os=>"Firefox OS",
#  :windows=>"Windows",
#  :linux=>"Generic Linux",
#  :other=>"Other"}
# > Browser::Platform.matchers.map { |b| b.new('').id }
# => [:adobe_air, :chrome_os, :windows_mobile, :windows_phone, :android, :blackberry, :ios, :mac, :firefox_os, :windows, :linux, :other]
