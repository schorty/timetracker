class CalendarStatistics::StatisticsCalculator
  def initialize(periods = {}, configs)
    @periods = periods
    @configs = configs
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
      .select("1, SUM(minutes_worked - #{@configs.daily_worktime}) AS overtime, SUM(minutes_worked) as minutes_worked")
      .where('beginning_of_day BETWEEN ? AND ?', period.start, period.end)
      .group(1)
      .find_by(business: 0..1)

    non_work_days = Day
      .select('1, SUM(minutes_worked) AS overtime, SUM(minutes_worked) as minutes_worked')
      .where('beginning_of_day BETWEEN ? AND ?', period.start, period.end)
      .group(1)
      .find_by(business: 2..3)

    minutes_worked = work_days.nil? ? 0.0 : work_days.minutes_worked
    minutes_worked += non_work_days.minutes_worked if non_work_days

    overtime = work_days.nil? ? 0.0 : work_days.overtime
    overtime += non_work_days.overtime if non_work_days
    overtime *= (100 + overtime_bonus_factor) / 100

    CalendarStatistics::Statistics.new(minutes_worked: minutes_worked.round(2), overtime: overtime.round(2))
  end

  def overtime_bonus_factor
    @overtime_bonus ||= Integer((100 + @configs.overtime_bonus) / 100)
  end
end
