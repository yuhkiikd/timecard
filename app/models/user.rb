class User < ApplicationRecord
  belongs_to :affiliation, foreign_key: "affiliation_id"
  has_secure_password
  before_validation { mail.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  validates :mail, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :affiliation_id, presence: true
  validates :password, presence: true, length: { minimum: 8 }
end