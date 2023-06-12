require "sinatra"
require "sinatra/reloader"
require "require_all"
set :bind, "0.0.0.0"

# So we can escape HTML special characters in the view
include ERB::Util

# Sessions
enable :sessions
set :session_secret, "f640177efb908d7ea39f9133f7e6a6fa6d7cbfda421618cc0c254a400ca1e7d7"

# Database
require_relative "db/db"

# App
require_all "models"
require_all "controllers"
require_all "helpers"