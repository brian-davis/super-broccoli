require 'browser/aliases'
Browser::Base.include(Browser::Aliases)

# link_shortener_api/lib/browser_decorator.rb
Browser::Base.include(BrowserDecorator)

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

# "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36"
