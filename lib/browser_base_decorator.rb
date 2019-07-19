# BrowserBaseDecorator extends Browser::Base, defined in the browser gem.
module BrowserBaseDecorator
  # Include 'Desktop' as a device name, instead of 'Unknown'
  # > Browser.new("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36").device_or_desktop
  # => "Desktop"
  # > Browser.new("Mozilla/5.0 (iPhone; CPU iPhone OS 12_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1.1 Mobile/15E148 Safari/604.1").device_or_desktop
  # => "iPhone"
  # > Browser.new("").device_or_desktop
  # => "Unknown"
  def device_or_desktop
    return device.name if mobile?
    return 'Desktop' if known?
    'Unknown'
  end
end
