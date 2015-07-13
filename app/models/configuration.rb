class Configuration < ActiveRecord::Base
  belongs_to :user

  validates :daily_worktime, presence: true
  validates_numericality_of :daily_worktime, greater_than_or_equal_to: 0.0
  validates :overtime_bonus, presence: true
  validates_numericality_of :overtime_bonus, greater_than_or_equal_to: 0.0
end
