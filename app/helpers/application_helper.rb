module ApplicationHelper
  def pattern(str)
    pattern = GeoPattern.generate(str)
    pattern.uri_image
  end

  def current_user?(user)
    current_user && current_user == user
  end
end
