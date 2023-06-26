class User < ApplicationRecord
  before_update :non_updatable_admin
  before_destroy :undeletable_admin

  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :password, length: { minimum: 4 }

  private

  def non_updatable_admin
    throw :abort if User.where(admin: :true).count == 1 && self.admin_change == [true, false]
    errors.add :base, '管理者は最低1人必要です'
  end

  def undeletable_admin
    throw :abort if User.where(admin: :true).count == 1 && self.admin?
    errors.add :base, '管理者は最低1人必要です'
  end
end
