Framework.application.routes do
  get '/articles/:id', 'articles#show', 'article_path'
  get '/articles', 'articles#index', 'articles_path'
  post '/articles', 'articles#create', 'article_path'
end
