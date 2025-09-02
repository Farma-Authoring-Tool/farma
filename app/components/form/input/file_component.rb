class Form::Input::FileComponent < ViewComponent::Base
  def initialize(form:, attribute:, **options)
    super()
    @form = form
    @attribute = attribute
    @options = options
  end

  def call
    content_tag :div, class: 'flex flex-col' do
      file_field_tag
    end
  end

  private

    def file_field_tag
      @form.file_field @attribute, class: "block text-sm text-gray-500
                                        file:mr-4 file:py-2 file:px-4
                                        file:rounded-full file:border-0
                                        file:text-sm file:font-semibold
                                        file:bg-green-50 file:text-green-700
                                        hover:file:bg-green-100 mb-3 focus:outline-none", **@options
    end
end
