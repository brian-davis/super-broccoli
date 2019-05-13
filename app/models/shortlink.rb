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
class Shortlink < ApplicationRecord
  validates_presence_of :source
  validates_with ShortlinkSourceValidator

  validates_uniqueness_of :source # TODO: add index db validation, scoped to tenant, once multitenant.

  # Uniqueness constraint at db level.
  # No default value prevents blank value at save.
  before_save :set_slug

  enum status: [:active, :expired] # default 0 (active)

  # for task set_expired
  scope :expire_ready, -> { active.where('created_at < ?', 90.days.ago) }

  def as_json(options)
    filtered = %w[id click_count created_at updated_at]
    super(options.merge({ root: true, except: filtered }))
  end

  private

  def set_slug
    self.slug = generate_slug unless persisted? # don't reset
  end

  def generate_slug
    loop do
      new_shortlink = ShortlinkFormatter::Slug.generate
      unless Shortlink.active.where(slug: new_shortlink).exists?
        break new_shortlink
      end
    end
  end
end
