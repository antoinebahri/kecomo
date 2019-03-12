class Restaurant < ApplicationRecord
  has_many :meals
  has_many :awards, through: :meals
  belongs_to :user, optional: true
  validates :name, presence: true, uniqueness: { scope: :address }
  validates :city, presence: true
  validates :name, presence: true

end
