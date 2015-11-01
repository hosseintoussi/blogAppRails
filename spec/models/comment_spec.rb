require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:published_article) { create(:article) }
  let!(:unpublished_article) { create(:article, title: 'unpublished', published_at: nil) }
  let!(:comment) { create(:comment, article: published_article, user: user, email: user.email) }

  describe '#article_should_be_published' do
    context 'passes validation' do
      it { expect(build(:comment, article: published_article, user: user, email: user.email)).to be_valid }
    end

    context 'fails validation' do
      it { expect(build(:comment, article: unpublished_article, user: user, email: user.email)).not_to be_valid }
    end
  end

  describe '#owned_by?' do
    it { expect(comment.owned_by?(user)).to eq(true) }
  end
end
