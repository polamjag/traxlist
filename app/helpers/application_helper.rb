module ApplicationHelper
  def google_search_url(str)
    "https://www.google.com/search?q=#{URI.encode str}"
  end
end
