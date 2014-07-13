class ProductsController < ApplicationController
  before_action :authenticate_user!, :redirect_when_not_owner, only: [:new, :edit, :update, :destroy, :create]
  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)

 
  
  def index
    
    @products = category.products
  end

  def show
    
  end

  def new
  end

  def edit
  end

  def create
    self.product = current_user.products.new(product_params)
    

    if product.save
      category.products << product
      redirect_to category_product_url(category, product), notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if product.update(product_params)
      redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /products/1
  def destroy
    categ = product.category
    product.destroy
    category_products_url(product.category)
    redirect_to category_url(categ), notice: 'Product was successfully destroyed.'
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id)
    end
    
    def redirect_when_not_owner
      if product.persisted? && current_user != product.user
        flash[:error] = "You are not allowed to edit this product."
        redirect_to category_product_path(product.category, product)
        
      end
    end
    
end
