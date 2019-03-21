class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @categories = Category.all
  end

  def profile
    @user = current_user
    @awards = @user.awards
    @awarded_categories = []
    @awards.each do |award|
      @awarded_categories << award.meal.category
    end
    @free_categories = []
    Category.all.each do |category|
      @free_categories << category unless @awarded_categories.include?(category)
    end
    @free_categories
  end
end
