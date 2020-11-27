class ArticlesController < Framework::Controller
  def index
    @time = Time.now
    @articles = Article.all
    # render 'articles/list'
  end

  def create; end
end
