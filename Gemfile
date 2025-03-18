source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.2'

gem 'pg', '~> 1.1'
gem 'rails', '~> 8.0.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.6'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'devise'
gem 'devise-jwt'
gem 'rack-cors'
gem 'rails-i18n', '~> 8.0.0'

gem 'whenever'

group :development do
  gem 'brakeman'
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-rails', require: false

  gem 'ostruct'
  gem 'rubycritic', '4.7.0', require: false
end

group :development, :test do
  gem 'bullet'
  gem 'factory_bot_rails'

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', '~> 3.3'
end

group :test do
  gem 'simplecov', require: false

  gem 'shoulda-context', '~> 2.0'
  gem 'shoulda-matchers', '~> 6.4.0'
end
