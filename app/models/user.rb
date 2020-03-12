class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  belongs_to :affiliation, foreign_key: "affiliation_id"
  has_many :time_card, dependent: :destroy
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  devise :validatable, password_length: 8..128
  devise :validatable, admin_presence: true
  validates :affiliation_id, presence: true
  before_destroy :least_one_destroy
  before_update :least_one_update
  
  private

  def least_one_destroy
    if User.where(admin: :true).count == 1 && self.admin?
      errors[:alert] << '管理者権限は最低1つ必要です。'
      throw :abort
    end
  end

  def least_one_update
    if User.where(admin: :true).count == 1 && self.admin? == false && self.admin_was == true
      errors[:alert] << '管理者権限は最低1つ必要です'
      throw :abort
    end
  end
end