require "sinatra"
require "sinatra/reloader"
set :bind, "0.0.0.0"


get "/index" do
  # ... app code ...
  erb :index
end
