require "sinatra"
set :bind, "0.0.0.0"


get "/example" do
  "hello world"
end

get "/example2" do
  "<html><body><h1>this is example 2</h1><body></html>"
end

get "/example3" do 
  @writeStuff = true
  erb :view
end