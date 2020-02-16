class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  belongs_to :affiliation, foreign_key: "affiliation_id"
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :affiliation_id, presence: true
  validates :password, presence: true, length: { minimum: 8 }
end