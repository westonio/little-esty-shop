class ApplicationController < ActionController::Base
  before_action :get_site_photos

  def get_site_photos
    Rails.logger.debug "Unsplash API Key: #{ENV['UNSPLASH_API_KEY']}"

    response = HTTParty.get('https://api.unsplash.com/photos', headers: {
                              'Authorization' => "Client-ID #{ENV['UNSPLASH_API_KEY']}"
                            })

    if response.success?
      @site_photos = JSON.parse(response.body)
      Rails.logger.debug "Photos: #{@site_photos.inspect}"
    else
      @error_message = "Error fetching photos from Unsplash: #{response.code} - #{response.body}"
      Rails.logger.debug "Error fetching photos: #{response.body}"
    end
  end

  def get_random_photo
    response = HTTParty.get('https://api.unsplash.com/photos/random', headers: {
                              'Authorization' => "Client-ID #{ENV['UNSPLASH_API_KEY']}"
                            })

    if response.success?
      @random_photo = JSON.parse(response.body)
    else
      @error_message = "Error fetching photos: #{response.code} - #{response.body}"
    end
  end

  def search_item_photos(search_term, page: 1, per_page: 1, order_by: 'relevant')
    query_term = search_term # using the argument here
    Rails.logger.debug "Query Term: #{query_term}"
    response = HTTParty.get('https://api.unsplash.com/search/photos',
                            headers: { 'Authorization' => "Client-ID #{ENV['UNSPLASH_API_KEY']}" },
                            query: { query: query_term, page:, per_page:, order_by: })
    Rails.logger.debug "Response: #{response.body}"

    if response.success?
      @item_photos = JSON.parse(response.body)['results']
    else
      @error_message = "Error fetching photos: #{response.code} - #{response.body}"
    end
  end
end
