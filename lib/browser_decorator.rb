module BrowserDecorator
  # include 'Desktop' as a device, instead of 'Unknown'
  def device_or_desktop
    return device.name if mobile?
    return 'Desktop' if known?
    'Unknown'
  end
end
