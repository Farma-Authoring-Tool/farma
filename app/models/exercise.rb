class Exercise < ApplicationRecord
  include Duplicate

  belongs_to :lo, counter_cache: true
  has_many :solution_steps, dependent: :destroy

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  before_create :set_position

  def duplicate
    ExerciseDuplicator.new(self).perform
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
