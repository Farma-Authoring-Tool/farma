module Breadcrumbs
  extend ActiveSupport::Concern

  included do
    helper_method :breadcrumbs
  end

  private

    def render(*args)
      default_breadcrumbs
      set_breadcrumbs if respond_to?(:set_breadcrumbs, true)
      super
    end

    def breadcrumbs
      @breadcrumbs ||= []
    end

    def add_breadcrumb(name, path = nil)
      breadcrumbs << Breadcrumb.new(name, path)
    end
end

class Breadcrumb
  attr_reader :name, :path

  def initialize(name, path)
    @name = name
    @path = path
  end

  def link?
    @path.present?
  end
end
