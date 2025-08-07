# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'shows background and logo images' do
    visit root_url

    assert_selector "img[alt='Estudantes mexendo em seus computadores']"
    assert_selector "img[alt='Logo FARMA']"
  end

  test 'shows navigation links with white text' do
    visit root_url

    assert_selector 'nav a.text-white', text: 'Professor'
    assert_selector 'nav a.text-white', text: 'Aluno'
    assert_selector 'nav a.text-white', text: 'Objetos'
  end

  test 'hows navigation link with green text' do
    visit root_url

    assert_selector 'nav a.text-green-500', text: 'Entrar em contato'
  end

  test 'shows hero section content' do
    visit root_url

    assert_selector 'h1', text: t('home.sections.hero.title')
    assert_selector 'p', text: t('home.sections.hero.subtitle')
  end

  test 'shows auth links' do
    visit root_url

    assert_selector "a[href='#{new_user_session_path}']", text: 'Acessar'
    assert_selector "a[href='#{new_user_registration_path}']", text: 'Cadastrar-se'
  end
end
