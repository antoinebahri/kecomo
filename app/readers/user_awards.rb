class UserAwards

  def fetch(current_user)
    current_user_awarded_categories = []
      current_user_awards = current_user.awards
      current_user_awards.each do |award|
        current_user_awarded_categories << award.meal.category
      end
    current_user_awarded_categories.sort
  end
end
