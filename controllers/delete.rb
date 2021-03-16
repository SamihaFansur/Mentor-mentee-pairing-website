post "/delete" do
  username = params["username"]

  if Mentee.username_exists?(username)
    mentee = Mentee[username]
    mentee.delete
    session.clear
    redirect "/index"
  end

  erb :delete_account
end
