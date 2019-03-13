class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @random_categories = Category.all.sample(12)
  end
end
