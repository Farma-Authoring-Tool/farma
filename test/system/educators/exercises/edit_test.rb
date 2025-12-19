require 'application_system_test_case'

class Educators::ExerciseControllerEditTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)

    @lo = create(:lo, user: @user)
    @exercise = create(:exercise, lo: @lo)

    visit edit_educators_lo_exercise_path(@lo, @exercise)
  end

  should 'successfully create a new Exercise' do
    fill_in I18n.t('activerecord.attributes.lo.title'), with: 'Novo Exercicio atualizado'

    assert_selector('iframe.tox-edit-area__iframe', wait: 5)

    within_frame(find('iframe.tox-edit-area__iframe')) do
      find_by_id('tinymce').set('Descrição do Exercicio atualizado')
    end

    check I18n.t('activerecord.attributes.exercise.draft')

    find("input[type='submit']").click

    assert_current_path educators_lo_path(@lo)
    assert_text I18n.t('educators.exercises.update.success')

    assert_text 'Novo Exercicio atualizado'
    assert_text 'Descrição do Exercicio atualizado'
  end

  should 'show validation errors when fields are blank' do
    fill_in I18n.t('activerecord.attributes.lo.title'), with: ''

    assert_selector('iframe.tox-edit-area__iframe', wait: 5)

    within_frame(find('iframe.tox-edit-area__iframe')) do
      find_by_id('tinymce').set('Descrição da introdução atualizado')
    end

    find("input[type='submit']").click

    assert_selector '.exercise_title p', text: I18n.t('errors.messages.blank')
  end
end
