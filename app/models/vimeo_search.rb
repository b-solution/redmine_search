class VimeoSearch < RedmineGlobalSearch

  BASE_URL = "https://vimeo.com/search?category=documentary"
  PARENT_CONTENT = '.thumbnail-content'
  COUNT = 6
  IMG_CSS = "img"
  TITLE_CSS = ".title"
  AUTHOR_CSS = ".author"

  attr_accessor :results, :contents

  def search
    page = get_html_parsed
    @contents = page.css(PARENT_CONTENT)
    @contents = @contents[0..COUNT-1] if @contents.count > COUNT
    @results = {}
    @contents.each_with_index do |content, idx|
      image = content.css(IMG_CSS).first.attributes['src'].value
      title = css(TITLE_CSS).last.children.first.text.gsub("\n", '').strip
      author = content.css(AUTHOR_CSS).first.children.first.text.gsub("\n", '').strip
      results["#{idx}"] = {image: image, title: title, author: author}
    end
  end

  def url
    "#{BASE_URL}&q=#{@query.gsub(' ', '+')}"
  end

end