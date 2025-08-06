# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'visiting the home page' do
    visit root_path

    assert_selector 'h1', text: t('home.sections.hero.title')
  end
end
