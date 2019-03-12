class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(cat_params)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category = Category.update(cat_params)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to root_path
  end

  private

  def cat_params
    params.require(:category).permit(:name)
  end
end
