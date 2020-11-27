Framework.application.routes do
  get '/articles', 'articles#index'
  post '/articles', 'articles#create'
end
