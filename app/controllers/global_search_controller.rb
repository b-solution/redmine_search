class GlobalSearchController < ApplicationController
  unloadable
  before_action :require_login


  def index
    if request.post?
      @results = {}
      if params[:google]
        @results[:google] = []
        Google::Search::Web.new(query: params[:q]).each do |rslt|
           @results[:google] << rslt
        end
      end

      true
    end
  end
end
