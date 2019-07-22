# frozen_string_literal: true

# ShortlinkSourceValidator is a custom validator for validating URL format
# on the :source attribute of a Shortlink.
class ShortlinkSourceValidator < ActiveModel::Validator
  def validate(record)
    return if valid?(record.source)

    record.errors.add(:source, 'is not a valid url.')
  end

  private

  # rubocop:disable Style/ColonMethodCall
  def valid?(source)
    return false unless source.present?

    regex = URI::regexp(%w[http https])
    # URI library bug allows 'http://'
    (regex === source) && URI::parse(source).host.present?
  end
  # rubocop:enable Style/ColonMethodCall
end
# TODO: spec
