module ApplicationHelper
  def format_date(time)
    time.strftime('%A, %B %d, %Y')
  end
end
