# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  article_id :integer
#  name       :string
#  email      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
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
