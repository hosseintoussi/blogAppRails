# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  hashed_password        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  role_id                :integer
#
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
