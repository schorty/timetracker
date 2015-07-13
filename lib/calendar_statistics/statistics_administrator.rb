class CalendarStatistics::StatisticsAdministrator
  ALL_PERIODS = [:weeks, :month, :year].freeze

  def initialize(periods, configs)
    @periods = periods == :all ? ALL_PERIODS : periods
    @periods_to_calculate = {}
    @configs = configs

    get_periods
  end

  def perform
    calculate_periods
  end

  private

  def get_periods
    get_period_for_year   if @periods.include? :year
    get_period_for_month  if @periods.include? :month
    get_period_for_week   if @periods.include? :week
    get_periods_for_weeks if @periods.include? :weeks
  end

  def get_period_for_year
    @periods_to_calculate[:year] = CalendarStatistics::Period.new(Time.now.beginning_of_year, Time.now.end_of_year.beginning_of_day)
  end

  def get_period_for_month
    @periods_to_calculate[:month] = CalendarStatistics::Period.new(Time.now.beginning_of_month, Time.now.end_of_month.end_of_day)
  end

  def get_period_for_week
    @periods_to_calculate[:week] = CalendarStatistics::Period.new(Time.now.beginning_of_week.end_of_day, Time.now.end_of_week.beginning_of_day)
  end

  def get_periods_for_weeks
    6.times do |i|
      start = Time.now.end_of_month.end_of_week.beginning_of_day + (1 - i).weeks
      @periods_to_calculate[:"week#{6 - i}"] = CalendarStatistics::Period.new(start.beginning_of_week.end_of_day, start.end_of_week.beginning_of_day)
    end
  end

  def calculate_periods
    sc = CalendarStatistics::StatisticsCalculator.new(@periods_to_calculate, @configs)

    sc.perform
  end
end
