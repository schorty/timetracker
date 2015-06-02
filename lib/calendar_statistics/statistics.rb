class CalendarStatistics::Statistics
  attr_reader :hours_worked, :overtime

  def initialize(hours_worked: 0.0, overtime: 0.0)
    @hours_worked = hours_worked
    @overtime = overtime
  end

  def printh(time = :overtime)
    if time == :overtime
      hours = @overtime.to_i
      minutes = ((@overtime % 1) * 60).to_i
    else
      hours = @hours_worked.to_i
      minutes = ((@hours_worked % 1) * 60).to_i
    end

    "#{hours}h, #{minutes}min"
  end
end
