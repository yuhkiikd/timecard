class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :affiliation, foreign_key: "affiliation_id"
  has_many :time_card, dependent: :destroy
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :affiliation_id, presence: true
  before_destroy :least_one_destroy
  before_update :least_one_update
  
  private

  def update_without_password(params, *options)
    # current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    # result = if valid_password?(current_password)
    #   update_attributes(params, *options)
    # else
    #   self.assign_attributes(params, *options)
    #   self.valid?
    #   self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
    #   false
    # end
    update_attributes(params, *options)

    clean_up_passwords
    result
  end

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