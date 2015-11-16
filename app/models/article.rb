# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  title        :string
#  body         :text
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  excerpt      :string
#  location     :string
#  user_id      :integer
#
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
