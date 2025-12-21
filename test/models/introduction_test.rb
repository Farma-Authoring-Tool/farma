require 'test_helper'

class IntroductionTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should allow_value(true).for(:public)
    should allow_value(false).for(:public)
    should_not allow_value(nil).for(:public)
    should_not allow_value('').for(:public)

    should 'enforce unique title per lo' do
      lo = FactoryBot.create(:lo)
      FactoryBot.create(:introduction, lo: lo, title: 'Duplicado')

      duplicate = FactoryBot.build(:introduction, lo: lo, title: 'Duplicado')

      assert_not duplicate.valid?
      assert_includes duplicate.errors[:title], I18n.t('errors.messages.taken')
    end
  end

  context 'relationships' do
    should belong_to(:lo)
    should have_many(:introductions_visualizations).dependent(:destroy)
  end

  context 'duplicate' do
    setup do
      @introduction = FactoryBot.create(:introduction)
    end

    should 'create a duplicate with the same attributes except id and title' do
      duplicated_introduction = @introduction.duplicate

      assert_not_nil duplicated_introduction
      assert_not_equal duplicated_introduction.id, @introduction.id

      assert_equal @introduction.position, duplicated_introduction.position

      assert_equal "Cópia 1 - #{@introduction.title}", duplicated_introduction.title
    end

    should 'increment copy number for each duplication' do
      assert_match(/Cópia 1 - /, @introduction.duplicate.title)
      assert_match(/Cópia 2 - /, @introduction.duplicate.title)
      assert_match(/Cópia 3 - /, @introduction.duplicate.title)
    end
  end

  context 'position initialization' do
    should 'set position on create' do
      introduction = FactoryBot.create(:introduction, position: nil)

      assert_not_nil introduction.position
    end
  end

  context 'visualizations and status' do
    setup do
      @introduction = FactoryBot.create(:introduction)
      @user = FactoryBot.create(:user)
      @team = FactoryBot.create(:team)
    end

    should 'return viewed status when visualization exists' do
      FactoryBot.create(:introductions_visualization, introduction: @introduction, user: @user, team: @team)

      assert_equal :viewed, @introduction.status(@user, @team)
    end

    should 'return not_viewed status when no visualization exists' do
      assert_equal :not_viewed, @introduction.status(@user, @team)
    end
  end
end
