class Profile::ChooseBtnComponent < ViewComponent::Base
  def initialize(path:, title:, desc:)
    @path = path
    @title = title
    @desc = desc
  end

  def title
    content_tag :h2, @title, class: 'text-sm md:text-xl font-bold text-gray-800 mb-2'
  end

  def desc
    content_tag :p, @desc, class: 'text-gray-500 text-xs md:text-base'
  end

  def link_to_profile
    link_to @path,
            class: 'block rounded-xl bg-white p-4 md:p-8 w-72 text-center duration-300 hover:-translate-y-2' do
      title + desc
    end
  end
end
