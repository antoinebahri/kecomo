class MealMailer < ApplicationMailer
  def creation_confirmation(user, meal)
    @user = user
    @meal = meal

    mail(
      to:       @user.email,
      subject:  "You have created a new meal!"
    )
  end
end
