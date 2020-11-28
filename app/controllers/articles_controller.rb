class ArticlesController < Framework::Controller
  def index
    @time = Time.now
    @articles = Article.all
    # render 'articles/list'
  end

  def show
    # status 222
    # headers['Content-Type'] = 'text/plain'

    @article = Article[params['id']]
  end

  def create; end
end
