class CalendarStatistics::Statistics
  attr_reader :minutes_worked, :overtime

  def initialize(minutes_worked: 0.0, overtime: 0.0)
    @minutes_worked = minutes_worked
    @overtime = overtime
  end

  def printh(time = :overtime)
    if time == :overtime
      hours = (@overtime / 60).to_i
      minutes = (@overtime % 60).to_i
    else
      hours = (@minutes_worked / 60).to_i
      minutes = (@minutes_worked % 60).to_i
    end

    "#{hours}h, #{minutes}min"
  end

  def +(statistics)
    @minutes_worked += statistics.minutes_worked
    @overtime += statistics.overtime
  end
end
