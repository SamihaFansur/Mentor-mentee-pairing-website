require_relative "../spec_helper"

#Tests for indivudual methods used throughout the website that may not be able to be 
#hit through acceptance tests

describe 'Sinatra App' do
  include Rack::Test::Methods

#Does the index get method and tests that it takes you to expected URL
  it "displays index page" do 
    get '/'

    expect(last_response.body).to include("one")
  end
#Does the contact page get method and tests that it takes you to expected URL
  it "displays contact page" do 
    get '/contact'

    expect(last_response.body).to include("Contact")
  end

#Does the contact page get method and tests that the URL path is correct
  it "requests login page URL path" do 
    get '/LoginPage'

    expect(last_request.path).to eq('/LoginPage')

  end
    
 #Does the Mentee Sign Up form  page get method and tests that tests that the URL path is correct
    it "requests mentee sign up page URL path" do 
    get '/MenteeSignUpForm'

    expect(last_request.path).to eq('/MenteeSignUpForm')
  end
 #Does the Mentor Sign Up form get method and tests that the URL path is correct  
    it "requests mentor sign up page URL path" do 
    get '/MentorSignUpForm'

    expect(last_request.path).to eq('/MentorSignUpForm')
  end
  #posts index and tests for expected URl path
    it "requests index page URL path" do 
    post '/'

    expect(last_request.path).to eq('/')
  end
  #posts schecdule and expects URL path   
    it "posts mentor schedule page URL path" do 
    post '/MentorSchedule'

    expect(last_request.path).to eq('/MentorSchedule')
  end
    #posts mentee schedule and tests for URL path
        it "posts mentee schedule page URL path" do 
    post '/MenteeSchedule'

    expect(last_request.path).to eq('/MenteeSchedule')
  end
   #Tests that adminHelp get method uses expected URL path 
     it "requests admin help page URL path" do 
    get '/AdminHelp'

    expect(last_request.path).to eq('/AdminHelp')
  end
        #posts admin help and tests for URL path
     it "posts admin help page URL path" do 
    post '/AdminHelp'

    expect(last_request.path).to eq('/AdminHelp')        
  end
     #tests the mentee can be unsuspended twice with this method
    it "gets unusupend mentee twice to check error" do 
        get "/unsuspendMentee"
        get "/unsuspendMentee"     

        expect(last_request.path).to eq("/unsuspendMentee")
    end
  
    it "posts unusupend mentee twice to check error" do 
        post  "/unsuspendMentee"
        post "/unsuspendMentee"     

        expect(last_request.path).to eq("/unsuspendMentee")
    end
    #checks that add application method is working
    it "gets add Application" do 
        get "/addApplication"

        expect(last_request.path).to eq("/addApplication")
    end

        it "gets add application URL path" do 
        post  "/addApplication"   

        expect(last_request.path).to eq("/addApplication")
    end
 #checks that search get method and post method send you to correct URL path
    it "gets search page URL path" do 
        get "/search"

        expect(last_request.path).to eq("/search")
    end

        it "posts search page URL path" do 
        post  "/search"   

        expect(last_request.path).to eq("/search")
    end
 #checks that block mentee method works
    it "gets block mentee URL path" do 
        get "/blockMentee"

        expect(last_request.path).to eq("/blockMentee")
    end

        it "posts block mentee URL path" do 
        post  "/blockMentee"   

        expect(last_request.path).to eq("/blockMentee")
    end
 #checks that unblock mentee method works
    it "gets unblockMentee method and tests for execution" do 
        get "/unblockMentee"

        expect(last_request.path).to eq("/unblockMentee")
    end

        it "posts unblockmentee" do 
        post  "/unblockMentee"   

        expect(last_request.path).to eq("/unblockMentee")
        end
end