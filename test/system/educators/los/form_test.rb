# frozen_string_literal: true

require 'application_system_test_case'

class FormTest < ApplicationSystemTestCase
  setup do
    @educator = create(:user)
    sign_in(@educator)
  end

  context 'creating a new LO' do
    setup do
      visit new_educators_lo_path
    end

    should 'successfully create a new LO' do
      fill_in I18n.t('activerecord.attributes.lo.title'), with: 'Novo OA'
      fill_in I18n.t('activerecord.attributes.lo.description'), with: 'Descrição do OA'
      # attach_file "Picture", Rails.root.join("app/images/test/los/default_lo.png")
      check I18n.t('educators.los.partials.forms.accessible')
      check I18n.t('educators.los.partials.forms.duplicable')

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

  context 'editing an existing LO' do
    setup do
      @lo = create(:lo, title: 'OA antigo', description: 'Descrição antiga', user: @educator)
      visit edit_educators_lo_path(@lo)
    end

    should 'successfully update the LO' do
      fill_in I18n.t('activerecord.attributes.lo.title'), with: 'OA atualizado'
      fill_in I18n.t('activerecord.attributes.lo.description'), with: 'Descrição atualizada'
      uncheck I18n.t('educators.los.partials.forms.accessible')
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
end
