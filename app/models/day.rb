class Day < ActiveRecord::Base
  enum business: {
    work_time: 0,
    home_time: 1,
    school:    2,
    vacation:  3,
    illness:   4
  }

  has_many :notices, dependent: :destroy

  validates :beginning_of_day, presence: true, uniqueness: true
  validates :hours_worked, presence: true, if: :is_work_day?

  private

  def is_work_day?
    business == "work_time"
  end
end
