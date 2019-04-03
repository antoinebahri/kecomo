class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :awards
  after_create :send_welcome_email

  def awarded_categories
    awards.map do |award|
      award.meal.category
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
