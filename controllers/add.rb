get "/add" do
  @mentee = Mentee.new
  erb :add
end

post "/add" do
  @mentee = Mentee.new
  @mentee.load(params)

  if @mentee.valid?
    @mentee.save_changes
    redirect "/edit"
  end

  erb :add
end
