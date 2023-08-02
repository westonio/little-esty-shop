class ApplicationController < ActionController::Base

  def logo_image
    photo = Unsplash::Photo.find("c9FQyqIECds")
  end
end
