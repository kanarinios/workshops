class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :reviews
  validates :title, :description, :price, presence: true
  validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
  
  def average_rating
    reviews = self.reviews
    avg = 0
    
    reviews.each do |r|
      avg = avg + r.rating
    end
    avg = avg/reviews.count.to_f
  end
end
