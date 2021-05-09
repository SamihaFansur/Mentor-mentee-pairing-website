require_relative "../spec_helper"

describe 'Sinatra App' do
  include Rack::Test::Methods


  it "displays index page" do 
    get '/'

    expect(last_response.body).to include("one")
  end

  it "displays contact page" do 
    get '/contact'

    expect(last_response.body).to include("Contact")
  end


  it "displays home page if there is no user" do 
    get '/LoginPage'

    expect(last_request.path).to eq('/LoginPage')

  end
    
    
    it "displays home page if there is no user" do 
    get '/MenteeSignUpForm'

    expect(last_request.path).to eq('/MenteeSignUpForm')
  end
        
    it "displays home page if there is no user" do 
    get '/MentorSignUpForm'

    expect(last_request.path).to eq('/MentorSignUpForm')
  end
    
    it "displays home page if there is no user" do 
    post '/'

    expect(last_request.path).to eq('/')
  end
    it "displays home page if there is no user" do 
    post '/MentorSchedule'

    expect(last_request.path).to eq('/MentorSchedule')
  end
        it "displays home page if there is no user" do 
    post '/MenteeSchedule'

    expect(last_request.path).to eq('/MenteeSchedule')
  end
     it "displays home page if there is no user" do 
    get '/AdminHelp'

    expect(last_request.path).to eq('/AdminHelp')
  end
     it "displays home page if there is no user" do 
    post '/AdminHelp'

    expect(last_request.path).to eq('/AdminHelp')
        
  end
it "displays home page if there is no user" do 
    get "/unsuspendMentee"
    get "/unsuspendMentee"     

    expect(last_request.path).to eq("/unsuspendMentee")
end
    it "displays home page if there is no user" do 
    post  "/unsuspendMentee"
    post "/unsuspendMentee"     

    expect(last_request.path).to eq("/unsuspendMentee")
end
it "displays home page if there is no user" do 
    get "/addApplication"

    expect(last_request.path).to eq("/addApplication")
end
    it "displays home page if there is no user" do 
    post  "/addApplication"   

    expect(last_request.path).to eq("/addApplication")
end
it "displays home page if there is no user" do 
    get "/search"

    expect(last_request.path).to eq("/search")
end
    it "displays home page if there is no user" do 
    post  "/search"   

    expect(last_request.path).to eq("/search")
end
it "displays home page if there is no user" do 
    get "/blockMentee"

    expect(last_request.path).to eq("/blockMentee")
end
    it "displays home page if there is no user" do 
    post  "/blockMentee"   

    expect(last_request.path).to eq("/blockMentee")
end
it "displays home page if there is no user" do 
    get "/unblockMentee"

    expect(last_request.path).to eq("/unblockMentee")
end
    it "displays home page if there is no user" do 
    post  "/unblockMentee"   

    expect(last_request.path).to eq("/unblockMentee")
    end
end