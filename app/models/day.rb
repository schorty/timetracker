class Day < ActiveRecord::Base
  enum business: {
    work_time: 0,
    school:    1,
    home_time: 2,
    vacation:  3,
    illness:   4
  }

  has_many :notices, dependent: :destroy
  belongs_to :user

  validates :beginning_of_day, presence: true, uniqueness: { scope: :user_id }
  validates :hours_worked, presence: true, if: :is_work_day?

  private

  def is_work_day?
    business == "work_time"
  end
end
