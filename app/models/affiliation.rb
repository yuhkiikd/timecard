class Affiliation < ApplicationRecord
  validation :name, presence: true, uniqueness: true
end