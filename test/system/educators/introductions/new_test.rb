require 'application_system_test_case'

class NewTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)

    @lo = FactoryBot.create(:lo, user: @user)

    visit new_educators_lo_introduction_path(@lo)
  end

  should 'successfully create a new Introduction' do
    fill_in I18n.t('activerecord.attributes.introduction.title'), with: 'Nova introdução'

    within_frame(find('iframe[id$="_description_ifr"]')) do
      find('body').click
      find('body').set('Descrição da introdução')
    end

    check I18n.t('activerecord.attributes.introduction.draft')

    click_on I18n.t('educators.introductions.new.submit')

    assert_current_path educators_lo_path(@lo)

    assert_text I18n.t('educators.introductions.create.success')

    assert_text 'Nova introdução'
    assert_text 'Descrição da introdução'
  end

  should 'show validation errors when fields are blank' do
    click_on I18n.t('educators.introductions.new.submit')

    assert_selector '.introduction_title p', text: I18n.t('errors.messages.blank')
  end
end
