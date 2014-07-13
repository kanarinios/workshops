class User < ActiveRecord::Base
  attr_accessor(:firstname, :lastname, :email, :password, :password_confimation)
  validates :firstname,:lastname, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews
  has_many :products
end
