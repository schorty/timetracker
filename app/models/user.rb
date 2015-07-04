class User < ActiveRecord::Base
  has_many :days, dependent: :destroy
  has_one :configuration, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_default_configuration

  private

  def create_default_configuration
    Configuration.create({daily_worktime: 480, overtime_bonus: 0, user_id: self.id})
  end
end
