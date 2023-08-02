module ApplicationHelper
  def format_date(time)
    time.strftime('%A, %B %d, %Y')
  end

  # Unplash Methods
  def logo_image
    Unsplash::Photo.find('c9FQyqIECds')
  end

  def random_image
    Unsplash::Photo.random
  rescue StandardError => e
    if e.message.include?("Rate Limit Exceeded")
      nil
    else
      raise e
    end
  end
end
