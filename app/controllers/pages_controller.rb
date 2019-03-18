class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @random_categories = Category.all.sample(Category.all.size)
  end

  def profile
    @user = current_user
    @awards = @user.awards
  end
end
