require 'rails_helper'

RSpec.describe CalendarStatistics::StatisticsAdministrator, type: :model do
  describe 'StatisticsAdministrator' do
    Timecop.travel(Time.parse('May 31 2000'))

    context 'with day records' do
      before do
        5.times do |c|
          FactoryGirl.create(:day, hours_worked: 8.5, beginning_of_day: Time.parse('April 24 2000') + c.days, business: 0)
        end
        3.times do |c|
          FactoryGirl.create(:day, hours_worked: 8.5, beginning_of_day: Time.parse('May 01 2000') + c.days, business: 0)
        end
        5.times do |c|
          FactoryGirl.create(:day, hours_worked: 9.5, beginning_of_day: Time.parse('May 08 2000') + c.days, business: 0)
        end
        5.times do |c|
          FactoryGirl.create(:day, hours_worked: 7.5, beginning_of_day: Time.parse('May 15 2000') + c.days, business: 0)
        end
        7.times do |c|
          FactoryGirl.create(:day, hours_worked: 8.5, beginning_of_day: Time.parse('May 22 2000') + c.days, business: 0)
        end
        5.times do |c|
          FactoryGirl.create(:day, hours_worked: 8.5, beginning_of_day: Time.parse('May 29 2000') + c.days, business: 0)
        end
      end

      context 'when given week as argument' do
        let(:sa) { CalendarStatistics::StatisticsAdministrator.new([:week]) }

        it 'gathers statistics for current week' do
          statistics = sa.perform

          expect(statistics).to have_key(:week)
        end

        it 'accumulates hours_worked for current week' do
          statistics = sa.perform

          expect(statistics[:week].hours_worked).to be(5*8.5)
        end

        it 'doesn\'t accumulate statistics for month or year' do
          statistics = sa.perform

          expect(statistics).not_to have_key(:month)
          expect(statistics).not_to have_key(:year)
        end
      end

      context 'when given weeks as argument' do
        let(:sa) { CalendarStatistics::StatisticsAdministrator.new([:weeks]) }
        let(:statistics) { sa.perform }

        it 'gathers statistics for the last 6 weeks' do
          expect(statistics).to have_key(:week1)
          expect(statistics).to have_key(:week2)
          expect(statistics).to have_key(:week3)
          expect(statistics).to have_key(:week4)
          expect(statistics).to have_key(:week5)
          expect(statistics).to have_key(:week6)
        end

        it 'accumulates hours_worked for 4 weeks before current week' do
          expect(statistics[:week1].hours_worked).to be(3*8.5)
        end

        it 'accumulates hours_worked for 3 weeks before current week' do
          expect(statistics[:week2].hours_worked).to be(5*9.5)
        end

        it 'accumulates hours_worked for 2 weeks before current week' do
          expect(statistics[:week3].hours_worked).to be(5*7.5)
        end

        it 'accumulates hours_worked for 1 weeks before current week' do
          expect(statistics[:week4].hours_worked).to be(7*8.5)
        end

        it 'accumulates hours_worked for current week' do
          expect(statistics[:week5].hours_worked).to be(5*8.5)
        end

        it 'accumulates hours_worked for 1 week after current week' do
          expect(statistics[:week6].hours_worked).to be(0.0)
        end

        it 'doesn\'t accumulate statistics for week, month or year' do
          expect(statistics).not_to have_key(:week)
          expect(statistics).not_to have_key(:month)
          expect(statistics).not_to have_key(:year)
        end
      end

      context 'when given month as argument' do
        let(:sa) { CalendarStatistics::StatisticsAdministrator.new([:month]) }

        it 'gathers statistics for current month' do
          statistics = sa.perform

          expect(statistics).to have_key(:month)
        end

        it 'accumulates hours_worked for current month' do
          statistics = sa.perform

          expect(statistics[:month].hours_worked).to be(23*8.5)
        end

        it 'doesn\'t accumulate statistics for week or year' do
          statistics = sa.perform

          expect(statistics).not_to have_key(:week)
          expect(statistics).not_to have_key(:year)
        end
      end

      context 'when given year as argument' do
        let(:sa) { CalendarStatistics::StatisticsAdministrator.new([:year]) }

        it 'gathers statistics for current year' do
          statistics = sa.perform

          expect(statistics).to have_key(:year)
        end

        it 'accumulates hours_worked for current year' do
          statistics = sa.perform

          hours_worked = 0
          Day.all.each do |day|
            hours_worked += day.hours_worked
          end

          expect(statistics[:year].hours_worked).to be(hours_worked)
        end

        it 'doesn\'t accumulate statistics for week or month' do
          statistics = sa.perform

          expect(statistics).not_to have_key(:week)
          expect(statistics).not_to have_key(:month)
        end
      end
    end
  end
end
