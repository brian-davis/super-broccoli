module ShortlinkFormatter
  module Slug
    SLUG_SIZE = 6

    class << self
      def generate
        SecureRandom.alphanumeric(SLUG_SIZE)
      end

      def matcher
        /[a-zA-Z0-9]{#{SLUG_SIZE}}/
      end
    end
  end

  module Source
    class << self
      def matcher
        URI::regexp(%w(http https))
      end

      def valid?(source)
        (matcher === source) &&
        URI::parse(source).host.present?
      end
    end
  end
end
