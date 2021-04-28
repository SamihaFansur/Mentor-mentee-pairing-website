get "/reportMenteeForm" do
  @header = nil
  
  if session[:admins_username]
    if session[:mentors_username]
      @header = erb:"common/header_adminMentorA"
    else
      @header = erb:"common/header_adminA"
    end
  elsif session[:mentors_username]
    @header = erb:"common/header_mentorA"
  end
  
  @reports = Report.new
  @mentors = Mentor.first(id: params[:mentorID])
  
  erb :report_mentee
end

post "/reportMenteeForm" do  
  @reports = Report.new
  @reports.load(params)
  @reports.timeReportSent = Time.new
  @reports.save_changes
  
  mentor_reporting = Mentor.first(id: params[:mentorID])
    
  @mentor_report = mentor_reporting.reportMentee
  @mentor_report = 1 #already sent
  
  mentor_reporting.reportMentee = 1 #so field is updated in the the mentors table
  mentor_reporting.save_changes
  
  Thread.new{
#             sleep(48*60*60) #Button enabled after 2 days
            sleep(15) #----------------delete later -S----------------
            @mentor_report = 0 #resets so mentee can request mentor for a meeting again
            mentor_reporting.reportMentee = @mentor_report
            mentor_reporting.save_changes
            puts mentor_reporting.reportMentee
      }
  
  redirect "/myMentee"
  
  erb :report_mentee
end

get "/reports" do
 @header = nil
  
  if session[:admins_username]
    if session[:mentors_username]
      @header = erb:"common/header_adminMentorA"
    else
      @header = erb:"common/header_adminA"
    end
  end
  
  @reports = Report.order(:timeReportSent).all.reverse #All records in Reports table with most recent on top
  @reportsInfo = []
  
  @reports.each do |report|
    mentor = Mentor.first(id: report.mentorID)
    @reportsInfo.push([mentor.id, mentor.username, report.caption, report.id]) #Report and Mentor information
  end

  erb :mentor_reports
  
end

post "/dismissReport" do     
  report = Report.where(id: params[:reportID]).delete
      
  redirect "/reports"
end

get "/viewReport" do
  @header = nil
  
  if session[:admins_username]
    if session[:mentors_username]
      @header = erb:"common/header_adminMentorA"
    else
      @header = erb:"common/header_adminA"
    end
  end
  
  @reports = Report.where(id: params[:reportID])
  @reportsInfo = []
  
  @reports.each do |report|
    mentor = Mentor.first(id: report.mentorID)
    mentee = Mentee.first(id: mentor.menteeMatch)
    
    @reportsInfo.push([mentor.id, mentor.username, mentor.email, mentee.id, mentee.username, mentee.email, report.caption, report.description]) #Report and Mentor information
  end
  
  erb :view_mentor_report
end