require "sinatra"
set :bind, "0.0.0.0"

get "/index" do 
  @writeStuff = true
  erb :"views/index_view"
end