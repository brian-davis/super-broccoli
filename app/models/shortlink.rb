# mysql> describe shortlinks;
# +-------------+--------------+------+-----+---------+----------------+
# | Field       | Type         | Null | Key | Default | Extra          |
# +-------------+--------------+------+-----+---------+----------------+
# | id          | bigint(20)   | NO   | PRI | NULL    | auto_increment |
# | source      | text         | NO   |     | NULL    |                |
# | slug        | varchar(255) | NO   | UNI | NULL    |                |
# | click_count | int(11)      | YES  |     | 0       |                |
# | created_at  | datetime     | NO   |     | NULL    |                |
# | updated_at  | datetime     | NO   |     | NULL    |                |
# +-------------+--------------+------+-----+---------+----------------+
# 6 rows in set (0.00 sec)

class Shortlink < ApplicationRecord
  before_validation :set_slug

  validates_presence_of :source
  validate :validate_source

  validates_presence_of :slug
  validates_uniqueness_of :slug

  def as_json(options)
    filtered = %w[id click_count created_at updated_at]
    super(options.merge({ root: true, except: filtered }))
  end

  private

  def set_slug
    self.slug = generate_slug
  end

  def generate_slug
    loop do
      new_shortlink = ShortlinkFormatter::Slug.generate
      break new_shortlink unless Shortlink.where(slug: new_shortlink).exists?
    end
  end

  def validate_source
    if source.present? && !ShortlinkFormatter::Source.valid?(source)
      errors.add(:source, 'is not a valid shortlink')
    end
  end
end
