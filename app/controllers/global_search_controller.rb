class GlobalSearchController < ApplicationController
  unloadable
  before_action :require_login
  before_action :check_search

  def index
    if request.post?
      respond_to do |format|
        format.html{ }
        format.js{
        }
      end
    end
  end

  private

  def check_search
    if params[:query] || params[:page]
      @offset = nil
      @limit = Setting.search_results_per_page.to_i
      @limit = 10 if @limit == 0
      @question = params[:query] || session[:q] || ""
      session[:q] = @question
      @question.strip!
      @all_words = params[:all_words] ? params[:all_words].present? : true
      @titles_only = params[:titles_only] ? params[:titles_only].present? : false
      @search_attachments = params[:attachments].presence || '0'
      @open_issues = params[:open_issues] ? params[:open_issues].present? : false

      # quick jump to an issue
      if (m = @question.match(/^#?(\d+)$/)) && (issue = Issue.visible.find_by_id(m[1].to_i))
        redirect_to issue_path(issue)
        return
      end

      projects_to_search = User.current.projects
      @object_types = Redmine::Search.available_search_types.dup
      if projects_to_search.is_a? Project
        # don't search projects
        @object_types.delete('projects')
        # only show what the user is allowed to view
        @object_types = @object_types.select {|o| User.current.allowed_to?("view_#{o}".to_sym, projects_to_search)}
      end

      @scope = @object_types.select {|t| params[t]}
      @scope = @object_types if @scope.empty?

      fetcher = Redmine::Search::Fetcher.new(
          @question, User.current, @scope, projects_to_search,
          :all_words => @all_words, :titles_only => @titles_only, :attachments => @search_attachments, :open_issues => @open_issues,
          :cache => params[:page].present?, :params => params
      )

      if fetcher.tokens.present?
        @result_count = fetcher.result_count
        @result_count_by_type = fetcher.result_count_by_type
        @tokens = fetcher.tokens

        @result_pages = Paginator.new @result_count, @limit, params['page']
        @offset ||= @result_pages.offset
        @results = fetcher.results(@offset, @result_pages.per_page)
      else
        @question = ""
      end
    else
      session[:q] = nil
    end
  end

end
