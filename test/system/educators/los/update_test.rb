require 'application_system_test_case'

class UpdateTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)

    @lo = FactoryBot.create(:lo)

    visit edit_educators_lo_path(@lo)
  end

  should 'successfully update the LO' do
    fill_in I18n.t('activerecord.attributes.lo.title'), with: 'OA atualizado'
    fill_in I18n.t('activerecord.attributes.lo.description'), with: 'Descrição atualizada'
    uncheck I18n.t('activerecord.attributes.lo.accessible')
    click_on I18n.t('educators.los.edit.submit')

    assert_current_path educators_root_path
    assert_text I18n.t('educators.los.update.success')

    assert_text 'OA atualizado'
    assert_text 'Descrição atualizada'
  end

  should 'show validation errors when fields are blank' do
    fill_in I18n.t('activerecord.attributes.lo.title'), with: ''
    fill_in I18n.t('activerecord.attributes.lo.description'), with: ''

    click_on I18n.t('educators.los.edit.submit')

    assert_selector '.lo_title p', text: I18n.t('errors.messages.blank')
  end
end
