class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_many :sessions
  has_one :wallet, as: :ownable
end
