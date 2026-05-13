require 'test_helper'
require 'support/helpers/capybara_custom_assertions'
require 'capybara-screenshot'
require 'selenium/webdriver'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include CapybaraCustomAssertions
  include TestAssetHelpers

  SCREEN_SIZE = [1400, 1400].freeze
  REMOTE_DRIVER = :remote_chrome
  REMOTE_HTTP_TIMEOUT = 120

  Capybara.default_max_wait_time = 10
  i_suck_and_my_tests_are_order_dependent!

  def self.remote_selenium?
    ENV['SELENIUM_HOST'].present?
  end

  def self.chrome_preferences(driver_options)
    driver_options.add_argument('--disable-dev-shm-usage')
    driver_options.add_argument('--no-sandbox')
    driver_options.add_preference(:credentials_enable_service, false)
    # Do not show the weak password dialog during tests.
    driver_options.add_preference(:profile, { password_manager_leak_detection: false })
  end

  def self.remote_http_client
    Selenium::WebDriver::Remote::Http::Default.new(
      open_timeout: REMOTE_HTTP_TIMEOUT,
      read_timeout: REMOTE_HTTP_TIMEOUT
    )
  end

  def self.register_remote_driver
    Capybara.server_host = '0.0.0.0'

    Capybara.register_driver REMOTE_DRIVER do |app|
      url = "http://#{ENV.fetch('SELENIUM_HOST')}:#{ENV.fetch('SELENIUM_PORT', 4444)}/wd/hub"
      options = Selenium::WebDriver::Chrome::Options.new

      chrome_preferences(options)

      Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        url: url,
        options: options,
        http_client: remote_http_client
      )
    end
  end

  def self.register_screenshot_driver(name)
    Capybara::Screenshot.register_driver(name) do |driver, path|
      driver.browser.save_screenshot(path)
    end
  end

  if remote_selenium?
    register_remote_driver
    driven_by REMOTE_DRIVER, screen_size: SCREEN_SIZE

    setup do
      port = Capybara.current_session.server.port
      Capybara.app_host = "http://#{ENV.fetch('TEST_APP_HOST')}:#{port}"
    end
  else
    driver_options = { screen_size: SCREEN_SIZE }
    driver_options[:using] = :headless_chrome unless ENV['LAUNCH_BROWSER']

    driven_by :selenium, **driver_options do |browser_options|
      chrome_preferences(browser_options)
    end
  end

  register_screenshot_driver(:chrome)
  register_screenshot_driver(REMOTE_DRIVER)

  def before_teardown
    super
  rescue Selenium::WebDriver::Error::WebDriverError, Net::ReadTimeout, IOError
    nil
  end

  def after_teardown
    super
  rescue Selenium::WebDriver::Error::WebDriverError, Net::ReadTimeout, IOError
    nil
  end
end
