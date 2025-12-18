class Lo < ApplicationRecord
  include Duplicate

  ACCEPTED_PICTURE_TYPES = %w[image/png image/jpg image/jpeg].freeze
  ACCEPTED_PICTURE_TYPES_TEXT = ACCEPTED_PICTURE_TYPES.join(', ')

  has_one_attached :picture
  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy
  belongs_to :user

  has_many :los_teams, dependent: :delete_all
  has_many :teams, through: :los_teams

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :picture, content_type: ACCEPTED_PICTURE_TYPES, size: { maximum: 5.megabytes }, if: :picture_attached?

  def duplicate
    LoDuplicator.new(self).perform
  end

  def pages
    @pages ||= Logics::Lo::Pages.new(self)
  end

  def progress
    @progress ||= Logics::Lo::Progress.new(self)
  end

  delegate :attached?, to: :picture, prefix: true

  def picture_url
    return ActionController::Base.helpers.asset_url('bg/default_lo.png') unless picture.attached?

    Rails.application.routes.url_helpers.rails_blob_url(avatar)
  end
end
