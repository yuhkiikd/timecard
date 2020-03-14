class Affiliation < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  has_many :user, foreign_key: "affiliation_id", dependent: :restrict_with_error
  has_many :time_card, foreign_key: "affiliation_id", dependent: :restrict_with_error
end