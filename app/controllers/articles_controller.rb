class ArticlesController < Framework::Controller
  def index
    @time = Time.now
    # render 'articles/list'
  end

  def create; end
end
