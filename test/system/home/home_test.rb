# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  setup do
    visit root_url
  end

  should 'show header with logo and links' do
    within 'header#home-header' do
      assert_selector "img[alt='#{I18n.t('home.header.logo_alt')}']"
      assert_selector "img[src*='logo/farma-gray']"
    end

    within 'header#home-header nav' do
      assert_selector 'ul li:nth-child(1)', text: t('home.navigation.about')
      assert_selector 'ul li:nth-child(2)', text: t('home.navigation.team')
      assert_selector 'ul li:nth-child(3)', text: t('home.navigation.researches')
      assert_selector 'ul li:nth-child(4)', text: t('home.navigation.awards')
    end
  end

  should 'show background image' do
    within 'section#hero' do
      assert_selector "img[alt='#{I18n.t('home.sections.hero.background_alt')}']"
      assert_selector "img[src*='bg/home']"
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
