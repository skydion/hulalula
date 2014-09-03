module SupportsHelper
  def supports_header_data
    content_tag(:header, class: 'index_header') do
      content_tag(:span, class: 'index_header_text') do
        html = 'Supports list: '
        if admin?
          html.concat(
              link_to(image_tag('new-icon-24.png'), new_support_path, class: 'button')
              #link_to 'Add', new_support_path, class: 'button add'
          ).html_safe
        end
        html
      end
    end
  end
end
