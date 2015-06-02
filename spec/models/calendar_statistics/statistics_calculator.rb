require 'rails_helper'

RSpec.describe CalendarStatistics::StatisticsCalculator, :type => :model do
  describe "StatisticsCalculator" do
    before do
      20.times do |c|
        FactoryGirl.create(:day, hours_worked: 8.5, beginning_of_day: Time.now.beginning_of_day - c.days, business: 0)
      end
    end

    it 'can accumulate statistics for a given period' do
      period = CalendarStatistics::Period.new(Time.now.beginning_of_day - 6.days, Time.now.beginning_of_day)
      sc = CalendarStatistics::StatisticsCalculator.new({week: period})

      expect(sc.perform[:week].hours_worked).to be(7*8.5)
    end
  end
end
