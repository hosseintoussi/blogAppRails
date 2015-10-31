# t.string   "email"
# t.string   "hashed_password"
# t.datetime "created_at",                          null: false
# t.datetime "updated_at",                          null: false
# t.string   "encrypted_password",     default: "", null: false
# t.string   "reset_password_token"
# t.datetime "reset_password_sent_at"
# t.datetime "remember_created_at"
# t.integer  "sign_in_count",          default: 0,  null: false
# t.datetime "current_sign_in_at"
# t.datetime "last_sign_in_at"
# t.inet     "current_sign_in_ip"
# t.inet     "last_sign_in_ip"
# t.integer  "role_id"
require 'digest'
class User < ActiveRecord::Base
  has_one :profile
  belongs_to :role
  has_many :articles, -> { order('published_at DESC, title ASC') }, dependent: :nullify
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  before_create :set_default_role

  def self.search(query)
    query.delete_if { |_k, v| v.blank? }
    if query.key?(:email)
      where('email ILIKE ?', "%#{query['email']}%")
    else
      all
    end
  end

  ROLES = %w(admin moderator user banned)
  ROLES.each do |role|
    define_method("#{role}?") do
      role_name == role
    end
  end

  def setting_access?
    admin? || moderator?
  end

  def role_name
    role.name if role
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
