require_relative "../spec_helper"

#page links tests from /index
describe "the signup page" do
    it "is accessible from the index page" do
        visit"/index"
        click_link "Sign Up"
        expect(page).to have_content "Mentee"
    end
        

    it "is accessible from the index page" do
        visit"/index"
        click_link "Login"
        expect(page).to have_content "Dont have an account?"
    end
    
    

    it "is accessible from the index page" do
        visit"/index"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
    

    it "is accessible from the index page" do
        visit"/index"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end

    
    
    
 #page links tests from /login  


    it "is accessible from the login page" do
        visit"/login"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    

    it "is accessible from the login page" do
        visit"/login"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
    

    it "is accessible from the login page" do
        visit"/index"
        click_link "Login"
        expect(page).to have_content "Dont have an account?"
    end    

    
 #page links tests from /contact  

    it "is accessible from the contact page" do
        visit"/contact"
        click_link "Sign Up"
        expect(page).to have_content "Mentee"
    end
        

    it "is accessible from the contact page" do
        visit"/contact"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    

    it "is accessible from the contact page" do
        visit"/contact"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end

    it "is accessible from the contact page" do
        visit"/contact"
        click_link "Login"
        expect(page).to have_content "Dont have an account?"
    end  

    
 #page links tests from /SignUpChoices 

    it "is accessible from the SignUpChoices page" do
        visit"/SignUpChoices"
        click_link "Sign Up"
        expect(page).to have_content "Mentee"
    end
        

    it "is accessible from the SignUpChoices page" do
        visit"/SignUpChoices"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    

    it "is accessible from the SignUpChoices page" do
        visit"/SignUpChoices"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
    
end