# frozen_string_literal: true

require 'application_system_test_case'

class PasswordTest < ApplicationSystemTestCase
  setup do
    visit new_user_password_path
  end
end
