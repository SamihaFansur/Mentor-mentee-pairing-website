get "/search" do
  # @club_search = params.fetch("club_search",
  #                            request.cookies.fetch("club_search", "")).strip
  # response.set_cookie("club_search", @club_search)

  @courseName_search = params.fetch("courseName_search", "").strip

  @mentors = if @courseName_search.empty?
               Mentor.all
             else
               Mentor.where(Sequel.like(:courseName, "%#{@courseName_search}%"))
             end

  erb :mentor_search
end
