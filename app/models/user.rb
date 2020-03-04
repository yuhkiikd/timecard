class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :affiliation, foreign_key: "affiliation_id"
  belongs_to :time_card, foreign_key: "time_card_id", dependent: :destroy
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :affiliation_id, presence: true
  before_destroy :least_one

  private

  def least_one
    if User.where(admin: :true).count == 1 && admin == true
      errors[:base] << '管理者権限は最低1つ必要です'
      throw :abort
    end
  end
end