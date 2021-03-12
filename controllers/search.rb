get "/search" do
  # @club_search = params.fetch("club_search",
  #                            request.cookies.fetch("club_search", "")).strip
  # response.set_cookie("club_search", @club_search)

  @industry_search = params.fetch("industry_search", "").strip

  @mentors = if @industry_search.empty?
               Mentor.all
             else
               Mentor.where(Sequel.like(:industry, "%#{@industry_search}%"))
             end

  erb :mentor_search
end
