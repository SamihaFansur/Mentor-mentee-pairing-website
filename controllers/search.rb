get "/search" do
  @courseName_search = params.fetch("courseName_search", "").strip

  @mentors = if @courseName_search.empty?
               Mentor.order(:courseName).all
             else
               Mentor.order(:courseName).where(Sequel.ilike(:courseName, "%#{@courseName_search}%"))
             end

  erb :mentor_search
end

post "/addApplication" do
  @error = nil
  @requests = Request.new
  @requests.load(params[:menteeID].to_s, params[:mentorID].to_s)
  puts @requests
  
  if @requests.exist_application?
    @error = "Application already sent"
  else
    @requests.save_changes
  end
    redirect "/search"
end
  