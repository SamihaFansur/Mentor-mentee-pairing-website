get "/search" do
  @courseName_search = params.fetch("courseName_search", "").strip

  @mentors = if @courseName_search.empty?
               Mentor.order(:courseName).all
             else
               Mentor.order(:courseName).where(Sequel.ilike(:courseName, "%#{@courseName_search}%"))
             end

  erb :mentor_search
end
