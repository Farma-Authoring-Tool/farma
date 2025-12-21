require 'application_system_test_case'

class EditTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)

    @lo = FactoryBot.create(:lo, user: @user)

    @introduction = FactoryBot.create(:introduction, lo: @lo)

    visit edit_educators_lo_introduction_path(@lo, @introduction)
  end

  should 'successfully create a new introduction' do
    fill_in I18n.t('activerecord.attributes.introduction.title'), with: 'Nova Introdução atualizado'

    assert_selector('iframe.tox-edit-area__iframe', wait: 5)

    within_frame(find('iframe.tox-edit-area__iframe')) do
      find_by_id('tinymce').set('Descrição da introdução atualizado')
    end

    find("input[type='submit']").click

    assert_current_path educators_lo_path(@lo)

    assert_text I18n.t('educators.introductions.update.success')

    assert_text 'Nova Introdução atualizado'
    assert_text 'Descrição da introdução atualizado'
  end

  should 'show validation errors when fields are blank' do
    fill_in I18n.t('activerecord.attributes.introduction.title'), with: ''

    assert_selector('iframe.tox-edit-area__iframe', wait: 5)

    within_frame(find('iframe.tox-edit-area__iframe')) do
      find_by_id('tinymce').set('Descrição da introdução atualizado')
    end

    find("input[type='submit']").click

    assert_selector '.introduction_title p', text: I18n.t('errors.messages.blank')
  end
end
