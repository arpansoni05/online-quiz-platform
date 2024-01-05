class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :allocations, dependent: :destroy
  has_many :assessments, through: :allocations

  def jwt_payload
    super
  end

  enum role: { normal_user: 0, admin: 1 }
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :normal_user
  end

end
