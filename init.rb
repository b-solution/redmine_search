Redmine::Plugin.register :redmine_search do
  name 'Redmine Search plugin'
  author 'Bilel KEDIDI'
  description 'Plugin that search contents from different platform(Youtube, Google, Slideshare,...)'
  version '1.0.0'
  url 'https://www.github.com/bilel-kedidi/redmine_search'
  author_url 'https://www.github.com/bilel-kedidi'

  # GOOGLE_SEARCH_TOKEN= "AIzaSyAPMnZ2Z_uBqre0mlFi3TItyRhOnj2pWK8 "
  # KEY = "AIzaSyCWHl3DbYi63k9nzuwt_jqjk5U3__wuX0U"
  # Yt.configure do |config|
  #   config.api_key = KEY
  # end
  settings :default => {
      'cx_google'  => '001506635892206311296:b9rodotqxdg',
      'cx_quora'  => '001506635892206311296:-wm1jw1vy3c',
      'cx_slideshare'  => '001506635892206311296:p__vavbzjgm',
      'cx_vimeo'  => '001506635892206311296:tcihky2kwfo',
      'cx_youtube'  => '001506635892206311296:-epxehlckx8',
      'cx_scribd'  => '001506635892206311296:mwunsygnuqq'
  }, :partial => 'redmine_search_setting/setting'

  menu :top_menu, :global_search, {:controller => 'global_search', :action => 'index' },
       :caption => 'Global search'

end
