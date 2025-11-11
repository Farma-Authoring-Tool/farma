class Form::Input::FileComponent < Form::Input::BaseComponent
  def initialize(form:, attribute:, label: nil, **)
    super(form: form, attribute: attribute, type: :file, label: label, **)
  end

  def input
    content_tag :div, class: 'flex flex-col mt-1', data: { controller: 'preview' } do
      safe_join([
                  file_field_tag,
                  image_preview_tag
                ])
    end
  end

  private

    def file_field_tag
      content_tag :label do
        safe_join([
                    @form.file_field(@attribute, class: 'hidden',
                                                 data: { preview_target: 'input', action: 'change->preview#show' }, **@options),
                    content_tag(:span, 'Adicionar imagem', class: "block w-1/2 sm:w-1/3 md:w-1/4 lg:w-1/5 xl:w-1/6 
                                                                    py-2 px-4 rounded-full bg-green-100 text-green-600 
                                                                    text-sm text-center font-semibold 
                                                                    hover:bg-green-300 hover:text-white cursor-pointer 
                                                                    transition-colors duration-300")
                  ])
      end
    end

    def image_preview_tag
      content_tag(:img, nil, data: { preview_target: 'output' }, class: "w-full h-52 mt-4 object-cover
                                                                         border-0 rounded-md hidden")
    end
end
