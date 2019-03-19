module ApplicationHelper
  def public_page?(action_name)
    action_name == 'home'
  end
end
