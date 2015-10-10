require 'digest'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  #validates :role, presence: true

  has_one :profile
  belongs_to :role

  has_many :articles, -> { order('published_at DESC, title ASC')}, :dependent => :nullify
  has_many :comments

  before_create :set_default_role

  def admin?
    role.name == 'admin' rescue false
  end

  def moderator?
    role.name == 'moderator' rescue false
  end

  def user?
    role.name == 'user' rescue false
  end

  def banned?
    role.name == 'banned' rescue false
  end

  def has_setting_access?
    admin? || moderator?
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
