class Category < ApplicationRecord
  has_many :meals
  validates :name, presence: true, uniqueness: true

  include PgSearch
  multisearchable against: [:name]
end
