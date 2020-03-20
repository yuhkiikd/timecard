class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, password_length: 8..128

  belongs_to :affiliation, foreign_key: "affiliation_id"
  has_many :time_card, dependent: :destroy
  validates :name, presence: true,
                   length: { maximum: 30 }
  before_validation { email.downcase! }                  
  validates :email, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_destroy :least_one_destroy
  before_update :do_not_update_self_admin

  scope :asc, -> { order(id: "ASC") }

  private

  def least_one_destroy
    if User.where(admin: :true).count == 1 && self.admin?
      errors[:base] << '管理者権限は最低1つ必要です。'
      throw :abort
    end
  end

  def do_not_update_self_admin
    if User.where(admin: :true).count == 1 && self.admin? == false && self.admin_was == true
      errors[:base] << '管理者の変更は別の管理者から行ってください　※管理者権限は最低1つ必要です'
      throw :abort
    end
  end
end
