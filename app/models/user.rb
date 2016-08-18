class User < ApplicationRecord
  has_many :posts

  validates :email, :name, uniqueness: true
  validates :email, :name, :password, presence: true
  validates :password, length: { is: 6 }
  validates :password, confirmation: true
  validates :email, email: true

end
