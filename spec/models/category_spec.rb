require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { create(:category) }

  describe '.search' do
    it 'returns the category' do
      query = { name: category.name }
      expect(Category.search(query).first).to eq(category)
    end

    it 'returns all when query is blank' do
      query = { name: '' }
      expect(Category.search(query).count).to eq(Category.count)
    end
  end
end
