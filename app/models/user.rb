class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 10 }
  validates :mail, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  before_validation { mail.downcase! }
  belongs_to :affiliation, foreign_key: "affiliation_id"
end