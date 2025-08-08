# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  setup do
    visit root_url
  end

  should 'show background and logo images' do
    within 'section#hero' do
      assert_selector "img[alt='#{I18n.t('home.sections.hero.background_alt')}']"
      assert_selector "img[alt='#{I18n.t('home.sections.hero.logo_alt')}']"

      assert_selector "img[src*='bg/home']"
      assert_selector "img[src*='logo/farma-gray']"
    end
  end

  should 'show navigation links in the correct order' do
    within 'section#hero nav' do
      assert_selector 'a:nth-child(1)', text: t('home.navigation.about')
      assert_selector 'a:nth-child(2)', text: t('home.navigation.team')
      assert_selector 'a:nth-child(3)', text: t('home.navigation.researches')
      assert_selector 'a:nth-child(4)', text: t('home.navigation.awards')
    end
  end

  should 'show hero section title and short description' do
    within 'section#hero' do
      assert_selector 'h1', text: t('home.sections.hero.title')
      assert_selector 'p', text: t('home.sections.hero.subtitle')
    end
  end

  should 'show authentication links' do
    assert_selector "a[href='#{new_user_session_path}']", text: t('home.links.sign_in')
    assert_selector "a[href='#{new_user_registration_path}']", text: t('home.links.sign_up')
  end
end
