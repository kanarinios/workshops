class Product < ActiveRecord::Base
  #attr_accessor(:title, :description, :price)
  
  validates :title, presence: true
  validates  :description, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
  belongs_to :category
  belongs_to :user
  has_many :reviews
  
  
  def average_rating
    reviews = self.reviews
    avg = 0
    
    reviews.each do |r|
      avg = avg + r.rating
    end
    avg = avg/reviews.count.to_f
  end
end
