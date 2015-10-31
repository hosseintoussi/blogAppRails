require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }

  describe '.search' do
    it 'returns the email address' do
      query = { email: user.email }
      expect(User.search(query).first).to eq(user)
    end

    it 'returns all when query is blank' do
      query = { email: '' }
      expect(User.search(query).count).to eq(User.count)
    end
  end

  describe '#admin?' do
    it { expect(user.admin?).to eq(true) }
  end

  describe '#moderator?' do
    it { expect(user.moderator?).to eq(false) }
  end

  describe '#user?' do
    it { expect(user.user?).to eq(false) }
  end

  describe '#banned?' do
    it { expect(user.banned?).to eq(false) }
  end

  describe '#setting_access?' do
    it { expect(user.setting_access?).to eq(true) }
  end
end
