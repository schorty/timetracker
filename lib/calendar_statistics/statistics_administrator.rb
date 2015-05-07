class CalendarStatistics::StaticsAdministrator
  def initialize(periods)
    @periods = periods
    @statistics = {
      week:  {hours_worked: 0.0, overtime: 0.0},
      week1: {hours_worked: 0.0, overtime: 0.0},
      week2: {hours_worked: 0.0, overtime: 0.0},
      week3: {hours_worked: 0.0, overtime: 0.0},
      week4: {hours_worked: 0.0, overtime: 0.0},
      week5: {hours_worked: 0.0, overtime: 0.0},
      week6: {hours_worked: 0.0, overtime: 0.0},
      month: {hours_worked: 0.0, overtime: 0.0},
      year:  {hours_worked: 0.0, overtime: 0.0}
    }
  end

  def perform

  end
end
