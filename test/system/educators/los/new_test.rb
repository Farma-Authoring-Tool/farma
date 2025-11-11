require 'application_system_test_case'

class NewTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)

    visit new_educators_lo_path
  end

  should 'successfully create a new LO' do
    fill_in I18n.t('activerecord.attributes.lo.title'), with: 'Novo OA'
    fill_in 'no-tinymce', with: 'Descrição do OA'
    attach_file 'lo_picture',
                Rails.root.join('test/fixtures/files/default_lo.png'),
                visible: :all
    check I18n.t('activerecord.attributes.lo.accessible')
    check I18n.t('activerecord.attributes.lo.duplicable')

    click_on I18n.t('educators.los.new.submit')

    assert_current_path educators_root_path

    assert_text I18n.t('educators.los.create.success')

    assert_text 'Novo OA'
    assert_text 'Descrição do OA'
  end

  should 'show validation errors when fields are blank' do
    click_on I18n.t('educators.los.new.submit')

    assert_selector '.lo_title p', text: I18n.t('errors.messages.blank')
  end
end
