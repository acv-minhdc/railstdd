class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    (flash[:error] = 'Update fail') if @product.update(product_params)
    redirect_to product_path(@product)
  end

  def create
    @product = Product.new(product_params)
    return redirect_to products_path if @product.save!
    render :new
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
  end

  private

    def product_params
      params.require(:product).permit(:title, :description, :category_id, :price)
    end
end
