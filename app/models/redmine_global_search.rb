class RedmineGlobalSearch
  attr_accessor :query, :page

  require 'nokogiri'
  require 'open_uri'
  def initialize(query)
    @query = query
  end

  def get_html_parsed
     html = open(url)
     Nokogiri::HTML.parse(html)
  end

  def search

  end

  def url
    fail("You should declare this method on subclasses")
  end

end