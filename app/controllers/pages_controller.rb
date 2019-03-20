class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @categories = Category.all
  end

  def profile
    @user = current_user
    @awards = @user.awards
  end
end
