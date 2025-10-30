# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
class FixUniqueIndexesForIntroductionsExercisesSolutionStepsAndTips < ActiveRecord::Migration[8.0]
  def change
    remove_index :introductions, :title if index_exists?(:introductions, :title)
    unless index_exists?(:introductions, [:title, :lo_id], unique: true)
      add_index :introductions, [:title, :lo_id], unique: true, name: 'index_introductions_on_title_and_lo_id'
    end

    remove_index :exercises, :title if index_exists?(:exercises, :title)
    unless index_exists?(:exercises, [:title, :lo_id], unique: true)
      add_index :exercises, [:title, :lo_id], unique: true, name: 'index_exercises_on_title_and_lo_id'
    end

    remove_index :solution_steps, :title if index_exists?(:solution_steps, :title)
    unless index_exists?(:solution_steps, [:title, :exercise_id], unique: true)
      add_index :solution_steps, [:title, :exercise_id], unique: true,
                                                         name: 'index_solution_steps_on_title_and_exercise_id'
    end

    remove_index :tips, :title if index_exists?(:tips, :title)
    return if index_exists?(:tips, [:title, :solution_step_id], unique: true)

    add_index :tips, [:title, :solution_step_id], unique: true, name: 'index_tips_on_title_and_solution_step_id'
  end
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
