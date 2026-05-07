require 'test_helper'
require 'support/helpers/capybara_custom_assertions'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include CapybaraCustomAssertions
  include TestAssetHelpers

  Capybara.default_max_wait_time = 10

  options = { screen_size: [1400, 1400] }
  options[:using] = :headless_chrome unless ENV['LAUNCH_BROWSER']

  driven_by :selenium, **options do |driver_options|
    driver_options.add_preference(:credentials_enable_service, false)
    # not show dialog when password is weak
    driver_options.add_preference(:profile, { password_manager_leak_detection: false })
  end
end

# Necessary to correct working of screenshot
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
