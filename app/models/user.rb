class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  belongs_to :role
  has_many :properties
  has_many :reservations
  #before_create :set_default_role
  #before_validation :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  #private
  #def set_default_role
  #  self.role ||= Role.find_by_name('host')
  #end
end
