require 'test_helper'
require 'support/helpers/capybara_custom_assertions'
require 'capybara-screenshot'
require 'selenium/webdriver'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include CapybaraCustomAssertions
  include TestAssetHelpers

  SCREEN_SIZE = [1400, 1400].freeze

  Capybara.default_max_wait_time = 10

  options = { screen_size: SCREEN_SIZE }
  options[:using] = :headless_chrome unless ENV['LAUNCH_BROWSER']

  driven_by :selenium, **options do |driver_options|
    driver_options.add_preference(:credentials_enable_service, false)
    # not show dialog when password is weak
    driver_options.add_preference(:profile, { password_manager_leak_detection: false })
    driver_options.add_argument('--disable-dev-shm-usage')
    driver_options.add_argument('--no-sandbox')
  end
end
