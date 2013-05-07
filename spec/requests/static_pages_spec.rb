require 'spec_helper'

describe "Static Pages" do
  
  describe "Home Page" do 
    it "should have the content 'Catechumen'" do
      visit '/static_pages/home'
      page.should have_content('Catechumen')
    end
    
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title',
                        :text => "Catechumen | Home")
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
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
    it "should have the content 'About Catechumen'" do
      visit '/static_pages/about'
      page.should have_content('About Catechumen')
    end
    
    it "should have the title 'About'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                        :text => "Catechumen | About")
    end
  end
  
end
