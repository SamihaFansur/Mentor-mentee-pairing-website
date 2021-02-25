require "sinatra"
require "sinatra/reloader"
set :bind, "0.0.0.0"


get "/example3" do
  # ... app code ...
  erb :view
end
