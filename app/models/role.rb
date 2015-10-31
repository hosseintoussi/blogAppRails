# t.string   "name"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
class Role < ActiveRecord::Base
  has_many :users
end
