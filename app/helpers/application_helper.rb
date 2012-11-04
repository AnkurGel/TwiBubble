module ApplicationHelper
  def home_page?
    if request.path.eql?('/') then true
    else false
    end
  end
end
