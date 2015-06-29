require 'rails_helper'

RSpec.describe CalendarStatistics::StatisticsCalculator, type: :model do
  describe 'StatisticsCalculator' do
    Timecop.travel(Time.parse('May 31 2000'))

    context 'with day records' do
      before do
        40.times do |c|
          FactoryGirl.create(:day, hours_worked: 8.5, beginning_of_day: Time.now.beginning_of_day - c.days, business: 0)
        end
      end

      context 'and a period of a week' do
        let (:period) { CalendarStatistics::Period.new(Time.now.beginning_of_day - 6.days, Time.now.beginning_of_day) }
        let (:sc) { CalendarStatistics::StatisticsCalculator.new({week: period}) }

        it 'accumulates hours_worked' do
          expect(sc.perform[:week].hours_worked).to be(7*8.5)
        end

        it 'accumulates overtime' do
          expect(sc.perform[:week].overtime).to be(7*0.5)
        end
      end

      context 'and a period of a month' do
        let (:period) { CalendarStatistics::Period.new(Time.now.beginning_of_month, Time.now.end_of_month.beginning_of_day) }
        let (:sc) { CalendarStatistics::StatisticsCalculator.new({month: period}) }

        it 'accumulates hours_worked' do
          expect(sc.perform[:month].hours_worked).to be(31*8.5)
        end

        it 'accumulates overtime' do
          expect(sc.perform[:month].overtime).to be(31*0.5)
        end
      end
    end

    context 'without day records' do
      let (:period) { CalendarStatistics::Period.new(Time.now.beginning_of_day - 60.days, Time.now.beginning_of_day - 54.days) }
      let (:sc) { CalendarStatistics::StatisticsCalculator.new({week: period}) }

      it 'has 0.0 as default for hours_worked' do
        expect(sc.perform[:week].hours_worked).to be(0.0)
      end

      it 'has 0.0 as default for overtime' do
        expect(sc.perform[:week].overtime).to be(0.0)
      end
    end

    it 'adds 100% work_time to overtime on non-work days' do
      FactoryGirl.create(:day, hours_worked: 8.5, beginning_of_day: Time.now.beginning_of_day - 100.days, business: :home_time)
      period = CalendarStatistics::Period.new(Time.now.beginning_of_day - 101.days, Time.now.beginning_of_day - 99.days)
      sc = CalendarStatistics::StatisticsCalculator.new({week: period})

      expect(sc.perform[:week].overtime).to be(8.5)
    end
  end
end
