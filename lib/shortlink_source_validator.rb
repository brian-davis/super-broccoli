class ShortlinkSourceValidator < ActiveModel::Validator
  def validate(record)
    if !valid?(record.source)
      record.errors.add(:source, 'is not a valid url.')
    end
  end

  private

  def valid?(source)
    return false unless source.present?
    (URI::regexp(%w(http https)) === source) && # URI library bug allows 'http://'
    URI::parse(source).host.present?
  end
end
