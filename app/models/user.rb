class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :name, length: { in: 3..32 }
  validates :email, length: { in: 5..256 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_save { email.downcase! }

  before_update :admin_user_last_update?
  before_destroy :admin_user_last_destroy?

  private

  def admin_user_last_update?
    @admin_user = User.where(admin: true)
    if (@admin_user.count == 1 && @admin_user.first == self) && !(self.admin?)
      #最後のadminですよっていう確認→checkboxの変更がされてるけど大丈夫？の確認
      errors.add(:user, '更新にエラーがあります。現在あなたのみが管理人のため管理人から外れることはできません。')
      throw :abort
    end

  end

  def admin_user_last_destroy?
    throw(:abort) if @admin_user.count == 1 && self.admin?
    errors.add(:user, 'には少なくとも１名のadmin権限者が必要です。')
  end
end
