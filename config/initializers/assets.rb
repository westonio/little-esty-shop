# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Unsplash.configure do |config|
  config.application_access_key = ENV["unsplash_access_key"]
  config.application_secret = ENV["unsplash_secret_key"]
  config.application_redirect_uri = "https://little-esty-shop-2eor.onrender.com"
  config.utm_source = "little-esty-shop"
end