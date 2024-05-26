class SolutionStep < ApplicationRecord
  include Duplicate

  enum :tips_display_mode,
       [:by_number_of_errors, :sequentially, :all_at_once],
       default: :by_number_of_errors,
       prefix: :tips

  belongs_to :exercise, counter_cache: true
  has_many :tips, dependent: :destroy
  has_many :solution_steps_visualizations, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  before_create :set_position

  def duplicate
    SolutionStepDuplicator.new(self).perform
  end

  def visualizations
    solution_steps_visualizations
  end

  def reorder_tips(tips_ids)
    transaction do
      tips_ids.each_with_index do |id, index|
        tips.find(id).update(position: index + 1)
      end
    end
  end

  def unviewed_tip(user, team)
    tips.each do |tip|
      return tip unless tip.viewed?(user, team)
    end
    nil
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
