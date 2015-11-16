# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles

  validates :name, presence: true, uniqueness: true

  def self.search(query)
    query.delete_if { |_k, v| v.blank? }
    if query.key?(:name)
      where('name ILIKE ?', "%#{query['name']}%")
    else
      all
    end
  end
end
