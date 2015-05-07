class OldStatisticsCalculator
  def initialize(start, period = :all)
    @start = start
    @period = period
  end

  def perform
    calc_statistics(@period)
  end

  def calc_statistics(period = :week)
    case period
    when :week
      calc_period_statistics(:week)
    when :month
      calc_period_statistics(:month)
    when :year
      calc_period_statistics(:year)
    else
      calc_all_statistics
    end
  end

  def calc_period_statistics(period)
    days = get_records_for_period(:period)
    hours_worked = 0
    overtime = 0

    days.each do |day|
      hours_worked += day.hours_worked
      if day.is_work_day?
        overtime += hours_worked - 8
      elsif day.hours_worked > 0
          overtime += hours_worked
        end
      end
    end

    {hours_worked: hours_worked, overtime: overtime}
  end

  def start_date
    @start ||= Time.now
  end

  def get_records_for_period(period)
    period_length = case period
    when :week
      Day.where(beginning_of_day: start_date..(start_date + 6.days))
    when :month
      Day.where(beginning_of_day: start_date..(start_date + 30.days))
    when :year
      Day.where(beginning_of_day: start_date..(start_date + 364.days))
    else
      Day.all
    end
  end
end
