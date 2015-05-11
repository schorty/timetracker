class CalendarStatistics::StatisticsAdministrator
  ALL_PERIODS = [:weeks, :month, :year].freeze

  def initialize(periods)
    @periods = periods == :all ? ALL_PERIODS : periods
    @periods_to_calculate = {}

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
    @periods_to_calculate[:year] = CalendarStatistics::Period.new(Time.now.beginning_of_year, Time.now.end_of_year)
  end

  def get_period_for_month
    @periods_to_calculate[:month] = CalendarStatistics::Period.new(Time.now.beginning_of_month, Time.now.end_of_month)
  end

  def get_period_for_week
    @periods_to_calculate[:week] = CalendarStatistics::Period.new(Time.now.beginning_of_week, Time.now.end_of_week)
  end

  def get_periods_for_weeks
    6.times do |i|
      start = Time.now.end_of_month + 1.week - i.weeks
      @periods_to_calculate[:"week#{6 - i}"] = CalendarStatistics::Period.new(start.beginning_of_week, start.end_of_week)
    end
  end

  def calculate_periods
    sc = CalendarStatistics::StatisticsCalculator.new(@periods_to_calculate)

    sc.perform
  end
end
