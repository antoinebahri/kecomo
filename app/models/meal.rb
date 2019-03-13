class Meal < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :awards
  validates :name, presence: true

  include PgSearch
  multisearchable against: [:name]
end
