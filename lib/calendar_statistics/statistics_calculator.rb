class CalendarStatistics::StatisticsCalculator
  def initialize(periods = [])
    @periods = periods
  end

  def perform
    output = []

    @periods.each do |period|
      output < get_statistics_for(period['period_start'], period['period_length'])
    end

    output
  end

  def get_statistics_for(period_start, period_end)
    period_start = [period_start, period_end].min
    period_end   = [period_start, period_end].max

    work_days = Day.all
      .select('1, SUM(hours_worked - 8) AS overtime, SUM(hours_worked) as hours_worked')
      .where(["beginning_of_day BETWEEN ? AND ?", period_start, period_end])
      .where(business: 0..1)
      .group(1)

    non_work_days = Day.all
      .select('1, SUM(hours_worked) AS overtime, SUM(hours_worked) as hours_worked')
      .where(["beginning_of_day BETWEEN ? AND ?", period_start, period_end])
      .where(business: 2..3)
      .group(1)

    result = work_days.merge(non_work_days){|k, old_v, new_v| old_v + new_v}

    Statistics.new(result['hours_worked'], result['overtime'])
  end
end
