class YoutubeSearch < RedmineGlobalSearch

  BASE_URL = "https://www.youtube.com/results"
  PARENT_CONTENT = '.ytd-item-section-renderer'
  COUNT = 6
  IMG_CSS = "img"
  TITLE_CSS = ".title"
  AUTHOR_CSS = ".author"

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
    videos = Yt::Collections::Videos.new
    videos.where(order: 'viewCount', q: @query.gsub(' ', '+'), :regionCode=> 'us')
  end

  def url
    "#{BASE_URL}?search_query=#{@query.gsub(' ', '+')}"
  end

end