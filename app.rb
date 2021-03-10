require "sinatra"
require "sinatra/reloader"
require "require_all"
set :bind, "0.0.0.0"

# So we can escape HTML special characters in the view
include ERB::Util

# Sessions
enable :sessions
set :session_secret, "$g]Rd2M/WbJ`~~<GZWdH@Fm'ESk2_gckCtLJJkySYG"

# Database
require_relative "db/db"

# App
require_all "models"
require_all "controllers"
require_all "helpers"