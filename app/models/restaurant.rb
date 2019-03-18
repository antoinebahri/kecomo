class Restaurant < ApplicationRecord
  has_many :meals
  has_many :awards, through: :meals
  belongs_to :user, optional: true
  validates :name, presence: true, uniqueness: { scope: :address }
  validates :city, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch
  multisearchable against: [:name, :city]

  # include PgSearch
  # pg_search_scope :search_by_cat, against: :category
end
