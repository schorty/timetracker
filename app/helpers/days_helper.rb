module DaysHelper
  def draw_calendar(day)
    day_start = day.beginning_of_week
    day_end = day_start + 41.days

    days = @days.where(beginning_of_day: (day_start..day_end)).order(:beginning_of_day).to_a

    [
      draw_calendar_head,
      draw_calendar_content(day_start, day, days)
    ].join.html_safe
  end

  def draw_calendar_head
    content_tag(:div, nil, class: 'calendar-head') do
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map do |column_label|
        content_tag(:div, column_label, class: 'calendar-column-label' + (['Sat', 'Sun'].include?(column_label) ? ' calendar-weekend' : ''))
      end.unshift(draw_month_statistics).join.html_safe
    end
  end

  def draw_calendar_content(current_day, selected_day, days)
    (0..5).map do |row|
      content_tag(:div, nil, class: 'calendar-row') do
        (0..7).map do |column|
          if column == 0
            out = draw_calendar_week_number(current_day, row)
          else
            day_content = days.find { |d| d.beginning_of_day.to_s == current_day.strftime('%Y-%m-%d').to_s }
            out = draw_calendar_day(current_day, day_content, row, column)
            current_day += 1.day
          end

          out
        end.join.html_safe
      end
    end
  end

  def draw_calendar_week_number(current_day, row)
    content_tag(:div, data: {row: row, column: 0}, class: 'calendar-row-label') do
      output = [
        content_tag(:div, current_day.strftime('CW %V')),
        content_tag(:div, "Worked: " + @statistics[:"week#{row + 1}"].printh(:hours_worked)),
        content_tag(:div, "Overtime: " + @statistics[:"week#{row + 1}"].printh(:overtime))
      ].join.html_safe
    end
  end

  def draw_calendar_day(current_day, day_content, row, column)
    content_tag(:div, data: {row: row, column: column}, class: 'calendar-entry' + (column > 5 ? ' calendar-weekend' : '')) do
      label = content_tag(:span, current_day.strftime('%d'), class: 'calendar-entry-day-label')

      content = if day_content
        draw_calendar_day_content(day_content)
      else
        link_to(fa_icon('plus'), new_day_path(beginning_of_day: current_day), class: 'btn btn-default calendar-entry-add-day')
      end

      [
        label,
        content
      ].join.html_safe
    end
  end

  def draw_calendar_day_content(content)
    [
      content_tag(:div, nil, class: 'calendar-entry-day') do
        day_entry = []

        day_entry << content_tag(:div, content.business, class: 'calendar-entry-day-line bold')
        day_entry << content_tag(:div, '%s Hours' % content.hours_worked, class: 'calendar-entry-day-line bold') if content.hours_worked

        content.notices.each do |notice|
          day_entry << content_tag(:div, link_to(notice.title, day_notice_path(content, notice)), class: 'calendar-entry-day-line')
        end

        day_entry.join.html_safe
      end,
      link_to(fa_icon('file-o'), new_day_notice_path(content), class: 'btn btn-default calendar-entry-add-notice'),
      link_to(fa_icon('pencil'), edit_day_path(content), class: 'btn btn-default calendar-entry-edit-day')
    ].join.html_safe
  end

  def draw_month_statistics
    month_statistics = CalendarStatistics::Statistics.new
    (2..5).each do |i|
      month_statistics + @statistics[:"week#{i}"]
    end

    content_tag(:div, nil, class: 'calendar-column-label') do
      [
        content_tag(:div, "This Month:"),
        content_tag(:div, "Worked: " + month_statistics.printh(:hours_worked)),
        content_tag(:div, "Overtime: " + month_statistics.printh(:overtime)),
        content_tag(:div, "This Year:"),
        content_tag(:div, "Worked: " + @statistics[:year].printh(:hours_worked)),
        content_tag(:div, "Overtime: " + @statistics[:year].printh(:overtime))
      ].join.html_safe
    end
  end
end
