class Lo < ApplicationRecord
  include Duplicate

  has_one_attached :picture
  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy
  belongs_to :user

  has_many :los_teams, dependent: :delete_all
  has_many :teams, through: :los_teams

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def duplicate
    LoDuplicator.new(self).perform
  end

  def pages
    @pages ||= Logics::Lo::Pages.new(self)
  end

  def progress
    @progress ||= Logics::Lo::Progress.new(self)
  end

  def picture_url
    if picture.attached?
      Rails.application.routes.url_helpers.rails_blob_path(picture, only_path: true)
    else
      ActionController::Base.helpers.asset_path('bg/default_lo.png')
    end
  end
end
