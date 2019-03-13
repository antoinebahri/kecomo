class Category < ApplicationRecord
  has_many :meals
  validates :name, presence: true, uniqueness: true

  include PgSearch
  multisearchable against: [:name]

  # index = Algolia::Index.new('categories')

  # index.set_settings(
  #   searchableAttributes: [
  #     'name'
  #   ],
  #   customRanking: [
  #     'desc(score)'
  #   ]
  # )
end
