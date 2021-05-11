#Mentor reporting their mentee
get "/reportMenteeForm" do
  headers_common_pages
  new_report_instance
  erb :report_mentee
end

post "/reportMenteeForm" do  
  new_report_instance
  @reports.load(params) #Loads the data typed into the form to be stored in the database
  @reports.timeReportSent = Time.new #Records time when report is sent
  @reports.save_changes
  
  mentor_reporting = Mentor.first(id: params[:mentorID]) #Gets the mentor based on mentor id, which it gets from the submit button on the form
  mentor_reporting.reportMentee = 1 #report already sent so sets reportMentee field to 1
  mentor_reporting.save_changes
  
  Thread.new{
            sleep(48*60*60) #Button enabled after 2 days
#             sleep(10) #button enabled after 10 secs, used when running rspec tests
            mentor_reporting.reportMentee = 0 #So mentor can report their mentee again
            mentor_reporting.save_changes
  }
  redirect "/myMentee"
end

#Admins view all mentee reports sent in by mentors
get "/reports" do
  headers_common_pages
  
  @reports = Report.order(:timeReportSent).all.reverse #All records in Reports table with most recent on top
  @reportsInfo = [] #Stores all the information related to each report
  
  @reports.each do |report|
    mentor = Mentor.first(id: report.mentorID) #Gets mentor record based on the mentor id stored in reports table
    @reportsInfo.push([mentor.id, mentor.username, report.caption, report.id]) #Report and Mentor information
  end

  erb :mentor_reports 
end

#Admin dismisses a report when its been dealt with
post "/dismissReport" do     
  report = Report.where(id: params[:reportID]).delete #deletes report from reports table
  redirect "/reports"
end

#Admin views the report in detail
get "/viewReport" do
  headers_common_pages
  
  #Gets the report based on report id, which it gets from the 'view' button being pressed to view report
  @reports = Report.where(id: params[:reportID])
  @reportsInfo = [] #Stores all the information related to the report
  
  @reports.each do |report|
    mentor = Mentor.first(id: report.mentorID) #The mentor who sent in the report, finds mentor based on mentor id stored in reports table
    #The mentee matched to the mentor, finds mentee based on the id stored in menteeMatch field in mentor table
    mentee = Mentee.first(id: mentor.menteeMatch)
    #Report, mentor and matched mentee information
    @reportsInfo.push([mentor.id, mentor.username, mentor.email, mentee.id, mentee.username, mentee.email, report.caption, report.description])
  end
  
  erb :view_mentor_report
end