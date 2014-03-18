require 'spec_helper'

describe "StaticPages" do

	let(:base_title) { "Grandstream Certification" }

  describe "Home page" do
    it "should have the content 'Grandstream Certification'" do
      visit '/static_pages/home'
      expect(page).to have_content('Grandstream Certification')
    end
    it "should have the right title" do 
			visit '/static_pages/home'
			expect(page).to have_title("#{base_title} | Home")
		end
  end
  
  describe "Help page" do 
  	it "should have the content 'Help'" do 
  		visit '/static_pages/help'
  		expect(page).to have_content('Help')
  	end
  end
  
  describe "Questions List page" do 
  	it "should have the content 'Questions'" do 
  		visit '/questions'
  		expect(page).to have_content('Questions')
  	end
  end
  
end
