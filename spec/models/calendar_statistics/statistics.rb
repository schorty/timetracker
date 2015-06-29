require 'rails_helper'

RSpec.describe CalendarStatistics::Statistics, type: :model do
  subject { CalendarStatistics::Statistics.new }

  describe "Statistics" do
    it "has default values" do
      expect(subject.hours_worked).not_to be(nil)
      expect(subject.overtime).not_to be(nil)
    end

    it "can print out overtime as human readable" do
      statistic = CalendarStatistics::Statistics.new(hours_worked: 9.5, overtime: 1.5)

      expect(statistic.printh(:overtime)).to eq("1h, 30min")
    end

    it "can print out hours worked as human readable" do
      statistic = CalendarStatistics::Statistics.new(hours_worked: 9.5, overtime: 1.5)

      expect(statistic.printh(:hours_worked)).to eq("9h, 30min")
    end
  end
end
