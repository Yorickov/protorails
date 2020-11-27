# Framework.application.db.create_table(:articles) do
#   primary_key :id
#   String :title, null: false
#   String :body, null: false
#   String :state, default: 'opened'
# end
# db[:articles].insert(title: 'Summer', body: 'Smth. hot')

class Article < Sequel::Model
end
