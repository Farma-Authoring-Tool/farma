require 'support/asset_helpers'
require 'support/simplecov'
require 'support/bullet'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

if defined?(Rails::TestUnitReporter)
  Rails::TestUnitReporter.class_eval do
    private

      def format_rerun_snippet(result)
        location, line =
          if result.respond_to?(:source_location)
            result.source_location
          else
            result.method(result.name).source_location
          end

        "#{self.class.executable} #{relative_path_for(location)}:#{line}"
      end
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    include ActionView::Helpers::TranslationHelper
    include Devise::Test::IntegrationHelpers
    include FactoryBot::Syntax::Methods
    include BulletHelper

    # Add more helper methods to be used by all tests here...

    parallelize_setup do |worker|
      SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}" if ENV['COVERAGE']
    end

    parallelize_teardown do |_worker|
      SimpleCov.result if ENV['COVERAGE']
    end
  end

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :minitest
      with.library :rails
    end
  end
end
