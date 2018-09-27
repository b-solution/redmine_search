class GoogleSearch < RedmineGlobalSearch
  attr_accessor :results, :contents

  # attributes[:id] = id
  # attributes[:snippet] = snippet
  # attributes[:status] = data['status']
  # attributes[:content_details] = data['contentDetails']
  # attributes[:statistics] = data['statistics']
  # attributes[:video_category] = data['videoCategory']
  # attributes[:claim] = data['claim']
  # attributes[:auth] = @auth

  def search
    query = GoogleSearchResults.new q: @query.gsub(' ', '+')
    hash = query.get_hash
    # PARAMS GOTTEN

    # :position => 1,
    # :title => "",
    # :link => "",
    # :displayed_link => "",
    # :snippet => "",
    # :cached_page_link => "",
    # :related_pages_link

    @results = hash[:organic_results].first(6)

  end

  def url
    ""
  end

end