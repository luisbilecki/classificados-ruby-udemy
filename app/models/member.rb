class Member < ActiveRecord::Base
  # Assocations
  has_many :ads
  has_one :profile_member

  # Gem RatyRate
  ratyrate_rater

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
