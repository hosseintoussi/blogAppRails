require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  describe '#published?' do
    it { expect(article.published?).to eq(true) }
  end

  describe '#owned_by?' do
    it { expect(article.owned_by?(user)).to eq(true) }
  end
end
