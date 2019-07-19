class ClickAttributeBuilder
  class << self
    alias_method :[], def call(request)
      {
        user_agent: request.user_agent,
        ip_address: request.remote_ip,
        referer:    request.referer
      }
    end
  end
end
