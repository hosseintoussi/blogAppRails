# t.string   "title"
# t.text     "body"
# t.datetime "published_at"
# t.datetime "created_at",   null: false
# t.datetime "updated_at",   null: false
# t.string   "excerpt"
# t.string   "location"
# t.integer  "user_id"
class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  scope :published, -> { where.not(published_at: nil) }
  scope :draft, -> { where(published_at: nil) }
  scope :recent, -> { published.where('articles.published_at > ?', 1.week.ago.to_date) }

  searchable do
    text :title, boost: 3
    text :excerpt, :body
    time :updated_at
  end

  def published?
    published_at.present?
  end

  def owned_by?(owner)
    return false unless owner.is_a?(User)
    user == owner
  end
end
