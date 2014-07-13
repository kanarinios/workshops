class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  
  def author
    self.user
  end
end
