class AwardMailer < ApplicationMailer
  def creation_confirmation(award)
    @award = award

    mail(
      to:       @award.user.email,
      subject:  "You have just voted for #{@award.meal} as best #{@award.meal.category}!"
    )
  end
end
