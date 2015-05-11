class CalendarStatistics::StatisticsCalculator
  def initialize(periods = {})
    @periods = periods
  end

  def perform
    output = {}

    @periods.each do |period_name, period|
      output[period_name] = get_statistics_for(period)
    end

    output
  end

  private

  def get_statistics_for(period)
    work_days = Day
      .select('1, SUM(hours_worked - 8) AS overtime, SUM(hours_worked) as hours_worked')
      .where(['beginning_of_day BETWEEN ? AND ?', period.start, period.end])
      .group(1)
      .find_by(business: 0..1)

    non_work_days = Day
      .select('1, SUM(hours_worked) AS overtime, SUM(hours_worked) as hours_worked')
      .where(['beginning_of_day BETWEEN ? AND ?', period.start, period.end])
      .group(1)
      .find_by(business: 2..3)

    hours_worked = work_days.nil? ? 0.0 : work_days.hours_worked
    hours_worked += non_work_days.hours_worked if non_work_days

    overtime = work_days.nil? ? 0.0 : work_days.overtime
    overtime += non_work_days.overtime if non_work_days

    CalendarStatistics::Statistics.new(hours_worked: hours_worked.round(2), overtime: overtime.round(2))
  end
end
