# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  birthday   :date
#  bio        :text
#  color      :string
#  twitter    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Profile < ActiveRecord::Base
  belongs_to :user
end
