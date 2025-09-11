module ApplicationHelper
  def full_title(page_title = '', base_title = t('app.short_name'))
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def sanitize_svg(svg)
    tags = %w[
      svg g path rect circle ellipse line polyline polygon text tspan defs use
      linearGradient radialGradient stop clipPath mask symbol
    ]
    attributes = %w[
      x y width height cx cy r rx ry d fill stroke stroke-width
      transform viewBox xmlns xlink:href style id class
    ]
    sanitize svg, tags: tags, attributes: attributes
  end
end
