class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates_presence_of :email, :body
  validate :article_should_be_published

  def article_should_be_published
    errors.add(:article_id, 'is not published yet') if article && !article.published?
  end

  def owned_by?(owner)
    return false unless owner.is_a?(User)
    user == owner
  end
end
