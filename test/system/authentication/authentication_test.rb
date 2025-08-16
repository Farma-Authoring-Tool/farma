# frozen_string_literal: true

require 'application_system_test_case'

class AuthenticationTest < ApplicationSystemTestCase
  setup do
    visit new_session_path
  end

  
end
