require 'rails_helper'

RSpec.describe CalendarStatistics::Period, type: :model do
  subject { CalendarStatistics::Period.new(Time.now - 10.days, Time.now) }

  describe "Period" do
    it 'has a start' do
      expect(subject.start).not_to be_nil
    end

    it 'has an end' do
      expect(subject.end).not_to be_nil
    end

    it 'start is before in time of end' do
      expect(subject.end).to be > subject.start
    end

    it 'swapps inputs if end is before in time of start' do
      inverse_period = CalendarStatistics::Period.new(Time.now, Time.now - 10.days)
      expect(inverse_period.end).to be > inverse_period.start
    end
  end
end
