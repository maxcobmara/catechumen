require 'spec_helper'

describe "Static Pages" do
  
  subject { page }
  
  describe "Home Page" do 
    before { visit root_path } 
    
    it { should have_selector('h1', text: 'Catechumen') }
    it { should have_selector 'title', text: "Catechumen" }
    it { should_not have_selector 'title', text: '| Home' }    
  end
  
  describe "Help page" do
    it "should have the h1 'Help'" do
      visit help_path
      page.should have_content('Help')
    end
    
    it "should have the title 'Home'" do
      visit help_path
      page.should have_selector('title',
                        :text => "Catechumen | Help")
    end
  end
  
  describe "About page" do
    it "should have the h1 'About Catechumen'" do
      visit about_path
      page.should have_content('About Catechumen')
    end
    
    it "should have the title 'About'" do
      visit about_path
      page.should have_selector('title',
                        :text => "Catechumen | About")
    end
  end
  
  describe "Contact page" do
    it "should have the h1 'Contact Us'" do
      visit contact_path
      page.should have_content('Contact Us')
    end
    
    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title',
                        :text => "Catechumen | Contact")
    end
  end
  
end
