require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should allow_value(true).for(:public)
    should allow_value(false).for(:public)
    should_not allow_value(nil).for(:public)
    should_not allow_value('').for(:public)

    should 'enforce unique title per lo' do
      lo = create(:lo)
      create(:exercise, lo: lo, title: 'Duplicado')

      duplicate = build(:exercise, lo: lo, title: 'Duplicado')

      assert_not duplicate.valid?
      assert_includes duplicate.errors[:title], t('errors.messages.taken')
    end
  end

  context 'relationships' do
    should belong_to(:lo)
    should have_many(:solution_steps)
    should have_many(:solution_steps).dependent(:destroy)
    should have_many(:exercises_visualizations).dependent(:destroy)
  end

  context 'duplicating an exercise' do
    setup do
      @exercise = FactoryBot.create(:exercise, title: 'Original Exercise')
      @solution_steps = FactoryBot.create_list(:solution_step, 2, exercise: @exercise)
      @solution_steps.each do |step|
        FactoryBot.create_list(:tip, 2, solution_step: step)
      end
    end

    should 'create a new exercise with a modified title' do
      duplicated_exercise = @exercise.duplicate

      assert_not_nil duplicated_exercise
      assert_not_equal duplicated_exercise.id, @exercise.id
      assert_equal "Cópia 1 - #{@exercise.title}", duplicated_exercise.title
    end

    should 'duplicate all associated solution steps' do
      duplicated_exercise = @exercise.duplicate

      assert_equal @solution_steps.size, duplicated_exercise.solution_steps.size

      @solution_steps.zip(duplicated_exercise.solution_steps).each do |original, duplicate|
        assert_equal original.tips.size, duplicate.tips.size
      end
    end
  end

  context 'reordering solution steps' do
    setup do
      @exercise = FactoryBot.create(:exercise)
      @solution_steps = FactoryBot.create_list(:solution_step, 3, exercise: @exercise)
    end

    should 'correctly reorder solution steps' do
      new_order_ids = @solution_steps.shuffle.map(&:id)

      @exercise.reorder_solution_steps(new_order_ids)

      new_order_ids.each_with_index do |id, index|
        step = SolutionStep.find(id)

        assert_equal index + 1, step.position, "SolutionStep with ID #{id} should be at position #{index + 1}"
      end

      assert_equal new_order_ids, @exercise.solution_steps.order(:position).pluck(:id)
    end
  end

  context 'position initialization' do
    should 'set position on create' do
      exercise = FactoryBot.create(:exercise, position: nil)

      assert_not_nil exercise.position
    end
  end

  context 'visualizations and status' do
    setup do
      @exercise = FactoryBot.create(:exercise)
      @user = FactoryBot.create(:user)
      @team = FactoryBot.create(:team)
    end

    should 'return viewed status when visualization exists' do
      FactoryBot.create(:exercises_visualization, exercise: @exercise, user: @user, team: @team)

      assert_equal :viewed, @exercise.status(@user, @team)
    end

    should 'return not_viewed status when no visualization exists' do
      assert_equal :not_viewed, @exercise.status(@user, @team)
    end
  end
end
