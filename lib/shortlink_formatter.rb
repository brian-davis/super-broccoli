# frozen_string_literal: true

module ShortlinkFormatter
  # ShortlinkFormatter::Slug provides utilities for enforcing correct Slug
  # format across the app.
  module Slug
    SLUG_SIZE = 6

    class << self
      def generate
        # 68_719_476_736 possible slugs
        SecureRandom.urlsafe_base64[0...SLUG_SIZE]
      end

      def matcher
        /[a-zA-Z0-9\-_]{#{SLUG_SIZE}}/
      end
    end
  end
end
# TODO - spec
