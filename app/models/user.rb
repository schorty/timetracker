class User < ActiveRecord::Base
  has_many :days, dependent: :destroy

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
