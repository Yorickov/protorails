class ArticlesController < Framework::Controller
  def index
    [
      200,
      { 'Content-Type' => 'text/plain' },
      ["All articles\n"]
    ]
  end

  def create
    [
      201,
      { 'Content-Type' => 'text/plain' },
      ["Article created\n"]
    ]
  end
end
