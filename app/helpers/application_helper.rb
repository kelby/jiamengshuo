module ApplicationHelper
  def pattern(str)
    pattern = GeoPattern.generate(str)
    pattern.uri_image
  end
end
