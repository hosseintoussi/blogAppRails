# t.string   "name"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
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
