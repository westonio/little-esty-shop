class ApplicationController < ActionController::Base
  before_action :get_photos

  def get_photos
    response = HTTParty.get('https://api.unsplash.com/photos', headers: {
                              'Authorization' => "Client-ID #{Unsplash::API_KEY}"
                            })

    if response.success?
      @photos = JSON.parse(response.body)
    else
      @error_message = 'Error fetching photos from Unsplash.'
    end
  end

  def get_random_photo
    response = HTTParty.get('https://api.unsplash.com/photos/random', headers: {
                              'Authorization' => "Client-ID #{Unsplash::API_KEY}"
                            })

    if response.success?
      @photo = JSON.parse(response.body)
    else
      @error_message = 'Error fetching a random photo from Unsplash.'
    end
  end
end
