module SupportsHelper
  def supports_header_data
    if admin?
      content_tag(:header, class: 'index_header') do
        'Supports list: '.concat(
          link_to(image_tag('new-icon-24.png'), new_support_path, class: 'button')
          #link_to 'Add', new_support_path, class: 'button add'
        ).html_safe
      end
    end
  end
end
