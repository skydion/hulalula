module RolesHelper
  def roles_header_data
    if admin?
      content_tag(:header, class: 'index_header') do
        'Roles list: '.concat(
            link_to(image_tag('new-icon-24.png'), new_role_path, class: 'button')
            #link_to 'Add', new_role_path, class: 'button add'
        ).html_safe
      end
    end
  end
end
