class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles

  validates :name, presence: true,  uniqueness: true
  default_scope lambda { order('categories.name') }
end
