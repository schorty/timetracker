class CalendarStatistics::Period
  attr_reader :start, :end

  def initialize(p_start, p_end)
    @start  = [p_start, p_end].min
    @end = [p_start, p_end].max
  end
end
