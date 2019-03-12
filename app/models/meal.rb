class Meal < ApplicationRecord
  include PgSearch
  belongs_to :restaurant
  belongs_to :category
  has_many :awards
  validates :name, presence: true

  pg_search_scope :search_by_cat_by_city, associated_against: {
    restaurant: [:city],
    category: :name
  }
end
