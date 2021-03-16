get "/edit" do
  username = params["username"]
  @mentees = Mentee[username] if Mentee.username_exists?(username)
  erb :edit_info
end

post "/edit" do
  username = params["username"]

  if Mentee.username_exists?(username)
    @mentees = Mentee[username]
    @mentees.load(params)

    if @mentees.valid?
      @mentees.save_changes
      redirect "/MenteeDashboard"
    end
  end

  erb :edit_info
end
