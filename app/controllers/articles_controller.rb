class ArticlesController < Framework::Controller
  def index
    @time = Time.now
    @articles = Article.all
    # render 'articles/list'

    # render plain: 'Plain renderer'
    # render html: '<h1>Plain renderer<h1/>'
    # render js: "alert('Hello Rails');"
    render json: { 'iam' => 'json' }
    # render xml: { lower_camel_case: 'key' }
  end

  def show
    # status 222
    # headers['Content-Type'] = 'text/plain'

    @article = Article[params['id']]
  end

  def create; end
end
