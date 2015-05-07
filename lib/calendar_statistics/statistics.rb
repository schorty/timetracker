class CalendarStatistics::Statistics
  attr_reader :hours_worked, :overtime

  def initialize(hours_worked:, overtime:)
    @hours_worked = hours_worked
    @overtime = overtime
  end
end
