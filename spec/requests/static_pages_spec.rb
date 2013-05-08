require 'spec_helper'

describe "Static Pages" do
  
  describe "Home Page" do 
    it "should have the h1 'Catechumen'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'Catechumen')
    end
    
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title',
                        :text => "Catechumen")
    end
    
    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end
    
  end
  
  describe "Help page" do
    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
    
    it "should have the title 'Home'" do
      visit '/static_pages/help'
      page.should have_selector('title',
                        :text => "Catechumen | Help")
    end
  end
  
  describe "About page" do
    it "should have the h1 'About Catechumen'" do
      visit '/static_pages/about'
      page.should have_content('About Catechumen')
    end
    
    it "should have the title 'About'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                        :text => "Catechumen | About")
    end
  end
  
  describe "Contact page" do
    it "should have the h1 'Contact Us'" do
      visit '/static_pages/contact'
      page.should have_content('Contact Us')
    end
    
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('title',
                        :text => "Catechumen | Contact")
    end
  end
  
end
