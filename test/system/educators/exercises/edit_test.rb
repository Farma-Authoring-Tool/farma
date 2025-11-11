require 'application_system_test_case'

class EditTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)

    @lo = FactoryBot.create(:lo, user: @user)

    @exercise = FactoryBot.create(:exercise, lo: @lo)

    visit edit_educators_lo_exercise_path(@lo, @exercise)
  end

  should 'successfully create a new Exercise' do
    fill_in I18n.t('activerecord.attributes.lo.title'), with: 'Novo Exercicio atualizado'

    within_frame(find('iframe[id$="_description_ifr"]')) do
      find('body').click
      find('body').set('Descrição do Exercicio atualizado')
    end

    check I18n.t('activerecord.attributes.exercise.draft')

    click_on I18n.t('educators.exercises.edit.submit')

    assert_current_path educators_lo_path(@lo)

    assert_text I18n.t('educators.exercises.update.success')

    assert_text 'Novo Exercicio atualizado'
    assert_text 'Descrição do Exercicio atualizado'
  end

  should 'show validation errors when fields are blank' do
    fill_in I18n.t('activerecord.attributes.lo.title'), with: ''

    within_frame(find('iframe[id$="_description_ifr"]')) do
      find('body').click
      find('body').set('')
    end

    click_on I18n.t('educators.exercises.edit.submit')

    assert_selector '.exercise_title p', text: I18n.t('errors.messages.blank')
  end
end
