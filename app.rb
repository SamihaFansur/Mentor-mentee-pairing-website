require "sinatra"
require "sinatra/reloader"
set :bind, "0.0.0.0"


get "/index" do
  # ... app code ...
  erb :index
end

get "/contact" do
  # ... app code ...
  erb :contact
end

get "/accessibility" do
  # ... app code ...
  erb :accessibility
end

get "/LoginPage" do
  # ... app code ...
  erb :login
end

get "/SignUpForm" do
  # ... app code ...
  erb :signup
end



post "/index" do
  puts params
  redirect "/index"

end