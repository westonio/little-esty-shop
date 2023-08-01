module ApplicationHelper
  def format_date(time)
    time.strftime('%A, %B %d, %Y')
  end

  # Unplash Methods
  def logo_image
    Unsplash::Photo.find('c9FQyqIECds')
  end
end
