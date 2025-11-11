require 'application_system_test_case'

class NewTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)

    @lo = FactoryBot.create(:lo, user: @user)

    visit new_educators_lo_exercise_path(@lo)
  end

  should 'successfully create a new Exercise' do
    fill_in I18n.t('activerecord.attributes.exercise.title'), with: 'Novo Exercicio'

    within_frame(find('iframe[id$="_description_ifr"]')) do
      find('body').click
      find('body').set('Descrição do Exercicio')
    end

    check I18n.t('activerecord.attributes.exercise.draft')

    click_on I18n.t('educators.exercises.new.submit')

    assert_current_path educators_lo_path(@lo)

    assert_text I18n.t('educators.exercises.create.success')

    assert_text 'Novo Exercicio'
    assert_text 'Descrição do Exercicio'
  end

  should 'show validation errors when fields are blank' do
    click_on I18n.t('educators.exercises.new.submit')

    assert_selector '.exercise_title p', text: I18n.t('errors.messages.blank')
  end
end
