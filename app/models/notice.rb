class Notice < ActiveRecord::Base
  belongs_to :day

  validates :title, presence: true
  validates :content, presence: true
end
