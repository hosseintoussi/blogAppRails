class Comment < ActiveRecord::Base
  validates_presence_of :email, :body
  validate :article_should_be_published

  belongs_to :article

  after_create :email_article_author

  def article_should_be_published
    errors.add(:article_id, "is not published yet") if article && !article.published?
  end

  def email_article_author
   # puts "We will notify #{article.user.email} in Chapter 9"
  end

end
